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
    required int id,
    required String email,
    required String username,
    required bool wannaBeArtist,
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
