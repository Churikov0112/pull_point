import '../../models/models.dart';

abstract class FavoritesRepositoryInterface {
  /// Добавление юзером артиста в избранное
  Future<bool> addToUserFavorites({required int artistId});

  /// Добавление юзером артиста в избранное
  Future<List<ArtistModel>?> getUserFavorites();
}
