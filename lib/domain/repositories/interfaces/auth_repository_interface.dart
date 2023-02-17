import '../../models/models.dart';

abstract class AuthRepositoryInterface {
  Future<UserModel?> checkAccountLocally();

  Future<bool?> checkUsernameExistence({required String username});

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

  /// Для получения пуш уведомлений
  Future<bool> updateUserDeviceToken(String deviceToken);
}
