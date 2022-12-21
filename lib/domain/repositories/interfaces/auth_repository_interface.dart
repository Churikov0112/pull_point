import '../../models/models.dart';

abstract class AuthRepositoryInterface {
  Future<UserModel?> checkAccountLocally();

  Future<UserModel?> refreshJWT();

  Future<String?> getVerificationCode({
    required String email,
  });

  Future<UserModel?> login({
    required String email,
    required String code,
  });

  Future<UserModel?> createUser({
    required UserModel userInput,
  });

  Future<void> logout();
}
