import 'dart:convert';
import '../../../domain/models/models.dart';
import '../../../domain/repositories/interfaces/favorites_repository_interface.dart';
import '../../../main.dart' as main;
import '../../http_requests/http_requests.dart';

class FavoritesRepositoryImpl implements FavoritesRepositoryInterface {
  FavoritesRepositoryImpl();

  @override
  Future<bool> addArtistToUserFavorites({required int artistId}) async {
    final response = await AddArtistToUserFavoritesRequest.send(
      artistId: artistId,
      jwt: main.userBox.get("user")?.accessToken,
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteArtistFromUserFavorites({required int artistId}) async {
    final response = await DeleteArtistFromUserFavoritesRequest.send(
      artistId: artistId,
      jwt: main.userBox.get("user")?.accessToken,
    );

    return response.statusCode == 200;
  }

  @override
  Future<List<ArtistModel>?> getUserFavorites() async {
    final response = await GetUserFavoritesRequest.send(
      jwt: main.userBox.get("user")?.accessToken,
    );

    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      final List<ArtistModel> favs = [];
      for (var artist in decodedResponse) {
        favs.add(ArtistModel.fromJson(artist));
      }
      return favs;
    }
    return null;
  }
}
