import 'package:flutter_riverpod/flutter_riverpod.dart';

final validatorProvider = Provider<Validator>((ref) {
  return Validator();
});

class Validator {
  String? validateEmail(String? email) {
    final value = email?.trim() ?? '';

    if (value.isEmpty) {
      return 'Введите email';
    }
    final regExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (!regExp.hasMatch(value)) {
      return 'Неверный формат email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    final value = password ?? '';

    if (value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 8) {
      return 'Пароль слишком короткий';
    }
    final regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
    if (!regExp.hasMatch(value)) {
      return 'Пароль должен содержать букву и цифру';
    }
    return null;
  }

  String? validateLoginPassword(String? password) {
    if ((password ?? '').isEmpty) {
      return 'Введите пароль';
    }
    return null;
  }

  String? validateName(String? name) {
    final value = name?.trim() ?? '';
    if (value.isEmpty) {
      return 'Введите имя';
    }
    return null;
  }
}
