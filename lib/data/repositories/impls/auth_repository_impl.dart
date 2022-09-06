import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/domain.dart';
import '../../config/config.dart';

class AuthRepositoryImpl extends AuthRepositoryInterface {
  AuthRepositoryImpl({
    required this.userBox,
  });

  Box<UserModel?> userBox;
  List<ArtistModel> artists = [];

  @override
  Future<UserModel?> checkAccountLocally() async {
    final result = userBox.get('user');
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
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
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
      final decodedResponse = jsonDecode(source);
      final UserModel user = UserModel.fromJson(decodedResponse["user"]);
      userBox.put("user", user);
      final result = userBox.get('user');
      print("login user.isArtist: ${result?.isArtist}");
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> updateUser({
    required UserModel userInput,
  }) async {
    final response = await http.put(
      Uri.parse("${BackendConfig.baseUrl}/auth"),
      body: jsonEncode({"id": userInput.id, "username": userInput.username, "phone": userInput.email}),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    final UserModel user;

    if (response.statusCode == 200) {
      user = UserModel(id: userInput.id, email: userInput.email, username: userInput.username, isArtist: userInput.isArtist);
      userBox.put("user", user);
      final result = userBox.get('user');
      print("updateUser user.isArtist: ${result?.isArtist}");
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<bool> iAmArtist({
    required UserModel userInput,
  }) async {
    final iAmArtistResponse = await http.post(
      Uri.parse("${BackendConfig.baseUrl}/auth/i_am_artist/${userInput.id}"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );

    final UserModel user;
    debugPrint("iAmArtistResponse.statusCode: ${iAmArtistResponse.statusCode}");

    if (iAmArtistResponse.statusCode == 200) {
      user = UserModel(id: userInput.id, email: userInput.email, username: userInput.username, isArtist: true);
    } else {
      user = UserModel(id: userInput.id, email: userInput.email, username: userInput.username, isArtist: false);
    }

    userBox.put("user", user);
    final result = userBox.get('user');
    print("iAmArtist user.isArtist: ${result?.isArtist}");
    return result?.isArtist ?? false;
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
      Uri.parse("${BackendConfig.baseUrl}/artist"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode({"subcategories": subcategoriesIds, "name": name, "description": description, "category": categoryId, "user": userId}),
    );
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
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
    return;
  }
}
