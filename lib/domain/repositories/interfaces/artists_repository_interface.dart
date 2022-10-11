import '../../models/models.dart';

abstract class ArtistsRepositoryInterface {
  Future<List<ArtistModel>> getArtists({
    String? search,
    int? categoryId,
    List<int>? subcategoryIds,
  });

  Future<List<ArtistModel>> getUserArtists({
    required int userId,
  });

  Future<bool> createArtist({
    required UserModel userInput,
    required String name,
    required String description,
    required int categoryId,
    required List<int>? subcategoryIds,
  });

  Future<bool> updateArtist({
    required int artistId,
    required String name,
    required String description,
    required int categoryId,
    required List<int>? subcategoryIds,
  });

  Future<bool> deleteArtist({
    required int artistId,
  });

  void selectArtist({
    required int artistId,
  });

  ArtistModel? getSelectedArtist();
}
