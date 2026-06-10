import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/ui/snack_bar.dart';
import 'package:guide_manager/core/utils/validator.dart';
import 'package:guide_manager/features/auth/data/auth_repository_impl.dart';
import 'package:guide_manager/features/auth/domain/auth_exception.dart';

class ResetPasswordSheet extends ConsumerStatefulWidget {
  const ResetPasswordSheet({super.key});

  @override
  ConsumerState<ResetPasswordSheet> createState() => _ResetPasswordSheetState();
}

class _ResetPasswordSheetState extends ConsumerState<ResetPasswordSheet> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                height: 3,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  color: AppColors.textMuted,
                ),
              ),
            ),
            Text(
              'Восстановление пароля',
              textAlign: TextAlign.start,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 23),
            ),
            const SizedBox(height: 12),
            Text(
              'Введите email, и мы отправим вам ссылку для восстановления пароля.',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: ref.read(validatorProvider).validateEmail,
                decoration: InputDecoration(
                  hintText: 'Введите email',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary.withValues(alpha: 0.85),
                  ),
                  prefixIcon: const Icon(Icons.mail_outlined),
                  prefixIconColor: AppColors.textSecondary.withValues(
                    alpha: 0.85,
                  ),
                  fillColor: AppColors.surface,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border, width: 1.3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.input),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const InfoWidget(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      minimumSize: const Size(0, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                    ),
                    onPressed: _isSubmitting
                        ? null
                        : () => Navigator.pop(context, false),
                    child: const Text('Отмена'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _isSubmitting
                        ? null
                        : () async {
                            final isValid =
                                _formKey.currentState?.validate() ?? false;
                            if (!isValid) return;

                            setState(() {
                              _isSubmitting = true;
                            });

                            try {
                              await ref
                                  .read(authRepositoryProvider)
                                  .sendResetPasswordEmail(
                                    _emailController.text.trim(),
                                  );

                              if (!context.mounted) return;
                              Navigator.pop(context, true);
                            } on AuthException catch (e) {
                              if (!context.mounted) return;
                              showAppToast(
                                context,
                                message: e.message,
                                type: AppToastType.error,
                              );
                            } catch (_) {
                              if (!context.mounted) return;
                              showAppToast(
                                context,
                                message: 'Не удалось отправить письмо',
                                type: AppToastType.error,
                              );
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isSubmitting = false;
                                });
                              }
                            }
                          },
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Отправить'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        color: AppColors.primary.withValues(alpha: 0.15),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Если аккаунт существует, письмо будет отправлено.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
