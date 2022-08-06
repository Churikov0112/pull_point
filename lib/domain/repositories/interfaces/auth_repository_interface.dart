import '../../models/models.dart';

abstract class AuthRepositoryInterface {
  Future<UserModel?> checkAccountLocally();

  Future<bool> sendVerificationCode({
    required String email,
  });

  Future<UserModel?> login({
    required String email,
    required String code,
  });

  Future<UserModel?> register({
    required int id,
    required String email,
    required String username,
  });

  Future<void> logout();
}
