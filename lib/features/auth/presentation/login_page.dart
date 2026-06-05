import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_manager/app/router.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:guide_manager/features/auth/presentation/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Image.asset('assets/images/traveltech.png', width: 275),
              const SizedBox(height: 60),
              Text(
                'Войдите в аккаунт',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              AuthTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.mail_outline),
              ),
              const SizedBox(height: 8),
              AuthTextField(
                controller: _passwordController,
                hintText: 'Пароль',
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
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(onPressed: () {}, text: 'Войти'),
              const SizedBox(height: 60),
              const Row(
                children: [
                  Expanded(child: Divider(thickness: 2, color: Colors.white)),
                  SizedBox(width: 8),
                  Text(
                    'Войти через',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Divider(thickness: 2, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                          image: const AssetImage('assets/icons/google.png'),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 36),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                          image: const AssetImage('assets/icons/apple.png'),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Нет аккаунта?',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => context.go(AppRoute.register.path),
                    child: Text(
                      'Регистрация',
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: AppColors.link),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Забыли пароль?',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppColors.link),
                ),
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
