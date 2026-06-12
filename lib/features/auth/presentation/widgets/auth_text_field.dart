import 'package:flutter/material.dart';
import 'package:guide_manager/app/theme.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 46),
      child: TextFormField(
        controller: controller,
        cursorColor: Theme.of(context).colorScheme.primary,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        validator: validator,
        style: TextStyle(color: colors.inputHint, fontSize: 17),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: prefixIcon,
                ),
          suffixIcon: suffixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: suffixIcon,
                ),
        ),
      ),
    );
  }
}
