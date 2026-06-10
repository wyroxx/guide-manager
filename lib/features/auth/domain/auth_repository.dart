abstract interface class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<void> loginWithApple();
  Future<void> loginWithGoogle();
  Future<void> sendResetPasswordEmail(String email);
}
