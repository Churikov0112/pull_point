import 'dart:convert';
import 'package:hive/hive.dart';

import '../../../domain/domain.dart';
import '../../http_requests/http_requests.dart';

class ArtistsRepositoryImpl extends ArtistsRepositoryInterface {
  ArtistsRepositoryImpl({
    required this.userBox,
  });

  Box<UserModel?> userBox;

  List<ArtistModel> userArtists = [];
  ArtistModel? selectedArtist;

  @override
  Future<List<ArtistModel>> getArtists({
    String? search,
    int? categoryId,
    List<int>? subcategoryIds,
  }) async {
    final List<ArtistModel> loadedArtists = [];
    final response = await GetArtistsRequest.send(
      search: search,
      categoryId: categoryId,
      subcategoryIds: subcategoryIds,
    );

    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      for (final element in decodedResponse) {
        loadedArtists.add(ArtistModel.fromJson(element));
      }
    }

    return loadedArtists;
  }

  @override
  Future<bool> createArtist({
    required UserModel userInput,
    required String name,
    required String description,
    required int categoryId,
    required List<int> subcategoriesIds,
  }) async {
    final response = await CreateArtistRequest.send(
      userId: userInput.id,
      name: name,
      description: description,
      categoryId: categoryId,
      subcategoriesIds: subcategoriesIds,
    );
    // записываем локально, что юзер - артист
    final UserModel user;
    if (response.statusCode == 200) {
      user = UserModel(id: userInput.id, email: userInput.email, username: userInput.username, isArtist: true);
      String source = const Utf8Decoder().convert(response.bodyBytes);
      userArtists.add(ArtistModel.fromJson(jsonDecode(source)));
    } else {
      user = UserModel(id: userInput.id, email: userInput.email, username: userInput.username, isArtist: false);
    }
    userBox.put("user", user);
    final result = userBox.get('user');

    return result?.isArtist ?? false;
  }

  @override
  Future<bool> updateArtist({
    required int userId,
    required String name,
    required String description,
    required int categoryId,
    required List<int> subcategoriesIds,
  }) async {
    final response = await UpdateArtistRequest.send(
      name: name,
      description: description,
      categoryId: categoryId,
      userId: userId,
      subcategoriesIds: subcategoriesIds,
    );
    return response.statusCode == 200;
  }

  @override
  void selectArtist({
    required int artistId,
  }) {
    if (userArtists.isNotEmpty) {
      selectedArtist = userArtists.firstWhere((artist) => artist.id == artistId);
    }
  }

  @override
  ArtistModel? getSelectedArtist() {
    return selectedArtist;
  }

  @override
  Future<List<ArtistModel>> getUserArtists({
    required int userId,
  }) async {
    final response = await GetUserArtistsRequest.send(userId: userId);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      userArtists.clear();
      for (final element in decodedResponse) {
        userArtists.add(ArtistModel.fromJson(element));
      }
    }

    return userArtists;
  }
}
