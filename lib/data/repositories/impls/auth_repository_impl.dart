import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/domain.dart';
import '../../config/config.dart';

class AuthRepositoryImpl extends AuthRepositoryInterface {
  AuthRepositoryImpl({
    required this.userBox,
  });

  UserModel? user;
  Box<UserModel?> userBox;

  List<ArtistModel> artists = [];

  @override
  Future<UserModel?> checkAccountLocally() async {
    final result = userBox.get('user');
    print("user: $result");
    return result;
  }

  @override
  Future<bool> sendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${BackendConfig.baseUrl}/auth/token"),
        body: jsonEncode({"phone": email}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      print(response.statusCode);
      String source = const Utf8Decoder().convert(response.bodyBytes);
      print(source);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<UserModel?> login({
    required String email,
    required String code,
  }) async {
    final response = await http.post(
      Uri.parse("${BackendConfig.baseUrl}/auth/verify"),
      body: jsonEncode({"phone": email, "token": code}),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      print("statusCode: ${response.statusCode}");
      final decodedResponse = jsonDecode(source);
      final UserModel user = UserModel.fromJson(decodedResponse["user"]);
      userBox.put("user", user);
      final result = userBox.get('user');
      print("user: $result");
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> updateUser({
    required int id,
    required String email,
    required String username,
    required bool wannaBeArtist,
  }) async {
    final response = await http.put(
      Uri.parse("${BackendConfig.baseUrl}/auth"),
      body: jsonEncode({"id": id, "username": username, "phone": email}),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    final UserModel user;

    if (response.statusCode == 200) {
      if (wannaBeArtist) {
        final iAmArtistResponse = await http.post(
          Uri.parse("${BackendConfig.baseUrl}/auth/i_am_artist/$id"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
        );

        if (iAmArtistResponse.statusCode == 200) {
          user = UserModel(id: id, email: email, username: username, isArtist: true);
        } else {
          user = UserModel(id: id, email: email, username: username, isArtist: false);
        }
        userBox.put("user", user);
        final result = userBox.get('user');
        print("user: $result");
        return user;
      } else {
        user = UserModel(id: id, email: email, username: username, isArtist: false);
        userBox.put("user", user);
        final result = userBox.get('user');
        print("user: $result");
        return user;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ArtistModel?> updateArtist({
    required int userId,
    required String name,
    required String description,
    required int categoryId,
    required List<int> subcategoriesIds,
  }) async {
    final response = await http.put(
      Uri.parse("${BackendConfig.baseUrl}/auth/artist"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode({
        "subcategories": subcategoriesIds,
        "name": name,
        "description": description,
        "category": categoryId,
        "user": userId
      }),
    );
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      print("decodedResponse: $decodedResponse");
      final ArtistModel artist = ArtistModel.fromJson(decodedResponse);
      if (artists.isEmpty) artists.add(artist);
      return artist;
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    userBox.clear();
    // userBox.close();
    return;
  }
}
