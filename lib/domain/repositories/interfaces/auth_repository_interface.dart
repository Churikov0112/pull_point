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

  Future<UserModel?> updateUser({
    required UserModel userInput,
  });

  Future<bool> iAmArtist({
    required UserModel userInput,
  });

  Future<ArtistModel?> updateArtist({
    required int userId,
    required String name,
    required String description,
    required int categoryId,
    required List<int> subcategoriesIds,
  });

  Future<void> logout();
}
