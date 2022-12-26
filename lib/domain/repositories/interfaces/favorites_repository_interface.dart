import '../../models/models.dart';

abstract class FavoritesRepositoryInterface {
  /// Добавление юзером артиста в избранное
  Future<bool> addArtistToUserFavorites({required int artistId});

  /// Удаление юзером артиста из избранного
  Future<bool> deleteArtistFromUserFavorites({required int artistId});

  /// Добавление юзером артиста в избранное
  Future<List<ArtistModel>?> getUserFavorites();
}
