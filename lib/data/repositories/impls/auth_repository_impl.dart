import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../domain/domain.dart';
import '../../http_requests/http_requests.dart';

class AuthRepositoryImpl extends AuthRepositoryInterface {
  AuthRepositoryImpl({
    required this.userBox,
  });

  Box<UserModel?> userBox;

  @override
  Future<UserModel?> checkAccountLocally() async {
    final result = userBox.get('user');
    return result;
  }

  @override
  Future<String?> getVerificationCode({
    required String email,
  }) async {
    final response = await SendCodeRequest.send(email: email);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      return decodedResponse["code"];
    } else {
      return null;
    }

  }

  @override
  Future<UserModel?> login({
    required String email,
    required String code,
  }) async {
    final response = await VerifyCodeRequest.send(email: email, code: code);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      final UserModel user = UserModel.fromJson(
        user: decodedResponse["user"],
        jwt: decodedResponse["jwt"],
      );
      userBox.put("user", user);
      final result = userBox.get('user');
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> createUser({
    required UserModel userInput,
  }) async {
    final response = await CreateUserRequest.send(
      id: userInput.id,
      username: userInput.username ?? "-",
      email: userInput.email,
    );
    final UserModel user;
    if (response.statusCode == 200) {
      user = UserModel(
        id: userInput.id,
        email: userInput.email,
        username: userInput.username,
        accessToken: userInput.accessToken,
        isArtist: userInput.isArtist,
      );
      userBox.put("user", user);
      final result = userBox.get('user');
      return result;
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
