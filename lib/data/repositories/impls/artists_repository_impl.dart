import 'dart:convert';

import '../../../domain/domain.dart';
import '../../../main.dart' as main;
import '../../http_requests/http_requests.dart';

class ArtistsRepositoryImpl extends ArtistsRepositoryInterface {
  ArtistsRepositoryImpl();

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
    required List<int>? subcategoryIds,
  }) async {
    final response = await CreateArtistRequest.send(
      name: name,
      description: description,
      categoryId: categoryId,
      subcategoriesIds: subcategoryIds,
      jwt: main.userBox.get("user")?.accessToken,
    );
    // print("userId: ${userInput.id}");
    // print("name: $name");
    // print("description: $description");
    // print("categoryId: $categoryId");
    // print("subcategoryIds: $subcategoryIds");

    // print("response.statusCode ${response.statusCode}");

    // записываем локально, что юзер - артист
    final UserModel user;
    if (response.statusCode == 200) {
      user = UserModel(
        id: userInput.id,
        email: userInput.email,
        username: userInput.username,
        isArtist: true,
        accessToken: main.userBox.get("user")?.accessToken,
      );
      String source = const Utf8Decoder().convert(response.bodyBytes);

      userArtists.add(ArtistModel.fromJson(jsonDecode(source)));
    } else {
      user = UserModel(
        id: userInput.id,
        email: userInput.email,
        username: userInput.username,
        isArtist: false,
        accessToken: main.userBox.get("user")?.accessToken,
      );
    }
    main.userBox.put("user", user);
    final result = main.userBox.get('user');

    return result?.isArtist ?? false;
  }

  @override
  Future<bool> updateArtist({
    required int artistId,
    required String name,
    required String description,
    required int categoryId,
    required List<int>? subcategoryIds,
  }) async {
    final response = await UpdateArtistRequest.send(
      name: name,
      description: description,
      categoryId: categoryId,
      artistId: artistId,
      subcategoriesIds: subcategoryIds,
      jwt: main.userBox.get("user")?.accessToken,
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteArtist({
    required int artistId,
  }) async {
    final response = await DeleteArtistRequest.send(
      artistId: artistId,
      jwt: main.userBox.get("user")?.accessToken,
    );
    if (response.statusCode == 200) {
      userArtists.removeWhere((element) => element.id == artistId);
      if (selectedArtist?.id == artistId) {
        selectedArtist = userArtists.first;
      }
    }
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
    selectedArtist ??= userArtists.first;
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

  @override
  void unselectArtistOnLogout() {
    userArtists.clear();
    selectedArtist = null;
  }

  @override
  Future<bool?> checkArtistNameExistence({required String artistName}) async {
    final response = await CheckArtistNameExistenceRequest.send(artistName: artistName);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      final isArtistNameFree = (decodedResponse as bool);
      final isArtistNameAlreadyExists = !isArtistNameFree;
      return isArtistNameAlreadyExists;
    }
    return null;
  }
}
