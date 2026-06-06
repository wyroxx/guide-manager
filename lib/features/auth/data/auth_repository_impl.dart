import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guide_manager/features/auth/domain/auth_exception.dart';
import 'package:guide_manager/features/auth/domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
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
    } on FirebaseAuthException catch (e) {
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
    } on FirebaseAuthException catch (e) {
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
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e));
    } catch (_) {
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
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw AuthException('Вход через Google отменён');
      }
      throw AuthException('Не удалось войти через Google');
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (_) {
      throw AuthException('Не удалось войти через Google');
    }
  }
}
