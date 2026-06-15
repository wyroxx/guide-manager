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

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  Future<void> _register(String name, String email, String password) async {
    if (_isSubmitting) return;
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref
          .read(authRepositoryProvider)
          .register(name.trim(), email.trim(), password);
    } on AuthException catch (e) {
      if (mounted) {
        showAppToast(context, message: e.message, type: AppToastType.error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 80),
              Text(
                'Создайте аккаунт',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _nameController,
                      hintText: 'Имя',
                      validator: ref.read(validatorProvider).validateName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                    const SizedBox(height: 8),
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
                      onPressed: _isSubmitting
                          ? null
                          : () async => await _register(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            ),
                      isLoading: _isSubmitting,
                      text: 'Регистрация',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 180),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Есть аккаунт?',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => context.go(AppRoute.login.path),
                    child: Text(
                      'Войти',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: colors.link),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
