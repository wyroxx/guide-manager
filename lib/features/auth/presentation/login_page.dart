import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_manager/app/router.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/ui/snack_bar.dart';
import 'package:guide_manager/core/utils/validator.dart';
import 'package:guide_manager/features/auth/data/auth_repository_impl.dart';
import 'package:guide_manager/features/auth/domain/auth_exception.dart';
import 'package:guide_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:guide_manager/features/auth/presentation/widgets/primary_button.dart';
import 'package:guide_manager/features/auth/presentation/widgets/reset_password_sheet.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  Future<void> _login(String email, String password) async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    try {
      await ref.read(authRepositoryProvider).login(email, password);
    } on AuthException catch (e) {
      if (mounted) {
        showAppToast(context, message: e.message, type: AppToastType.error);
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      await ref.read(authRepositoryProvider).loginWithGoogle();
    } on AuthException catch (e) {
      if (mounted) {
        showAppToast(context, message: e.message, type: AppToastType.error);
      }
    }
  }

  Future<void> _loginWithApple() async {
    try {
      await ref.read(authRepositoryProvider).loginWithApple();
    } on AuthException catch (e) {
      if (mounted) {
        showAppToast(context, message: e.message, type: AppToastType.error);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Image.asset(
                context.isDark
                    ? 'assets/images/traveltech.png'
                    : 'assets/images/traveltech_light.png',
                width: 275,
              ),
              const SizedBox(height: 60),
              Text(
                'Войдите в аккаунт',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: ref.read(validatorProvider).validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.mail_outline),
                    ),
                    const SizedBox(height: 8),
                    AuthTextField(
                      controller: _passwordController,
                      hintText: 'Пароль',
                      validator: ref.read(validatorProvider).validatePassword,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    PrimaryButton(
                      onPressed: () async => await _login(
                        _emailController.text,
                        _passwordController.text,
                      ),
                      text: 'Войти',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 2, color: colors.border)),
                  const SizedBox(width: 8),
                  Text(
                    'Войти через',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Divider(thickness: 2, color: colors.border)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.isLight
                            ? colors.border
                            : Colors.transparent,
                        width: 0.8,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async => await _loginWithGoogle(),
                          child: Ink.image(
                            image: const AssetImage('assets/icons/google.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 36),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.isLight
                            ? colors.border
                            : Colors.transparent,
                        width: 0.8,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async => await _loginWithApple(),
                          child: Ink.image(
                            image: const AssetImage('assets/icons/apple.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Нет аккаунта?',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => context.go(AppRoute.register.path),
                    child: Text(
                      'Регистрация',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: colors.link),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  final isSent = await showModalBottomSheet<bool>(
                    context: context,
                    isScrollControlled: true,
                    barrierColor: Colors.black54,
                    backgroundColor: colors.background,
                    builder: (context) => const ResetPasswordSheet(),
                  );

                  if (!context.mounted || isSent != true) return;

                  showAppToast(
                    context,
                    message: 'Письмо для восстановления отправлено',
                    type: AppToastType.success,
                  );
                },
                child: Text(
                  'Забыли пароль?',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: colors.link),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
