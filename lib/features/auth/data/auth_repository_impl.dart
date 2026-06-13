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
  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.info('Auth', 'Account registration succeeded');
    } on FirebaseAuthException catch (e, stackTrace) {
      _logFirebaseError('Account registration failed', e, stackTrace);
      throw AuthException(_mapFirebaseError(e));
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
      await FirebaseAuth.instance.signInWithProvider(AppleAuthProvider());
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

      await FirebaseAuth.instance.signInWithCredential(credential);
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
