import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guide_manager/core/logging/app_logger.dart';
import 'package:guide_manager/features/auth/domain/auth_exception.dart';
import 'package:guide_manager/features/auth/domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(appLoggerProvider));
});

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._logger);

  final AppLogger _logger;

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.info('Auth', 'Password sign-in succeeded');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Password sign-in failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _logger.info('Auth', 'Account registration succeeded');
      final user = credential.user;
      if (user == null) {
        throw AuthException('Не удалось создать пользователя');
      }
      await _ensureGuideRequest(user, preferredName: name);
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Account registration failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
    } catch (error, stackTrace) {
      _logger.error(
        'Auth',
        'Guide request creation failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthException('Не удалось отправить заявку на регистрацию');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        GoogleSignIn.instance.signOut(),
      ]);
      _logger.info('Auth', 'Sign-out succeeded');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Sign-out failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Пользователь не найден';
      case 'wrong-password':
        return 'Неверный пароль';
      case 'invalid-email':
        return 'Некорректный email';
      case 'network-request-failed':
        return 'Нет интернет соединения';
      case 'invalid-credential':
        return 'Неверный email или пароль';
      default:
        return 'Ошибка авторизации';
    }
  }

  @override
  Future<void> loginWithApple() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithProvider(
        AppleAuthProvider(),
      );
      final user = credential.user;
      if (user == null) {
        throw AuthException('Не удалось получить данные пользователя');
      }
      await _ensureGuideRequest(user);
      _logger.info('Auth', 'Apple sign-in succeeded');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Apple sign-in failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
    } catch (error, stackTrace) {
      _logger.error(
        'Auth',
        'Apple sign-in failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthException('Не удалось войти через Apple');
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) {
        throw AuthException('Не удалось получить данные пользователя');
      }
      await _ensureGuideRequest(user, preferredName: googleUser.displayName);
      _logger.info('Auth', 'Google sign-in succeeded');
    } on GoogleSignInException catch (e, stackTrace) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        _logger.info('Auth', 'Google sign-in canceled');
        throw AuthException('Вход через Google отменён');
      }
      _logger.error(
        'Auth',
        'Google sign-in failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException('Не удалось войти через Google');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Google Firebase sign-in failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
    } catch (error, stackTrace) {
      _logger.error(
        'Auth',
        'Google sign-in failed',
        error: error,
        stackTrace: stackTrace,
      );
      throw AuthException('Не удалось войти через Google');
    }
  }

  @override
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _logger.info('Auth', 'Password reset email sent');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Password reset request failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
    }
  }

  Future<void> _ensureGuideRequest(User user, {String? preferredName}) async {
    final guideReference = FirebaseFirestore.instance
        .collection('guides')
        .doc(user.uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final guideSnapshot = await transaction.get(guideReference);
      if (guideSnapshot.exists) {
        return;
      }

      final email = user.email;
      if (email == null || email.isEmpty) {
        throw AuthException('Провайдер не передал email пользователя');
      }

      transaction.set(guideReference, {
        'uid': user.uid,
        'email': email,
        'name': _guideName(preferredName ?? user.displayName, email),
        'isApproved': false,
        'level': '',
        'phone': '',
        'toursCount': 0,
        'avatar': '',
        'bio': '',
        'telegramAlias': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  String _guideName(String? preferredName, String email) {
    final name = preferredName?.trim() ?? '';
    if (name.isNotEmpty) {
      return name.length <= 100 ? name : name.substring(0, 100);
    }

    final emailName = email.split('@').first.trim();
    if (emailName.isNotEmpty) {
      return emailName.length <= 100 ? emailName : emailName.substring(0, 100);
    }

    return 'Новый гид';
  }

  void _logFirebaseError(
    String message,
    FirebaseAuthException error,
    StackTrace stackTrace,
  ) {
    _logger.error(
      'Auth',
      '$message (${error.code})',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
