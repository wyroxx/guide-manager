import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/core/utils/validator.dart';

void main() {
  late Validator validator;

  setUp(() {
    validator = Validator();
  });

  group('Validator.validateEmail', () {
    test('rejects empty and malformed emails', () {
      expect(validator.validateEmail(''), 'Введите email');
      expect(validator.validateEmail('guide@'), 'Неверный формат email');
    });

    test('accepts valid email', () {
      expect(validator.validateEmail('guide@example.com'), isNull);
    });
  });

  group('Validator.validatePassword', () {
    test('rejects empty, short, and digitless passwords', () {
      expect(validator.validatePassword(''), 'Введите пароль');
      expect(validator.validatePassword('a1b2'), 'Пароль слишком короткий');
      expect(
        validator.validatePassword('password'),
        'Пароль должен содержать букву и цифру',
      );
    });

    test('returns null for valid password', () {
      expect(validator.validatePassword('password1'), isNull);
      expect(validator.validatePassword(' pass123'), isNull);
    });
  });

  group('Validator.validateLoginPassword', () {
    test('requires a value without applying registration requirements', () {
      expect(validator.validateLoginPassword(''), 'Введите пароль');
      expect(validator.validateLoginPassword('short'), isNull);
      expect(validator.validateLoginPassword('12345678'), isNull);
    });
  });

  group('Validator.validateName', () {
    test('rejects empty name and accepts non-empty name', () {
      expect(validator.validateName(''), 'Введите имя');
      expect(validator.validateName('Александр'), isNull);
    });
  });
}
