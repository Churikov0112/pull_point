import 'dart:convert';

import '../../../domain/domain.dart';
import '../../../main.dart' as main;
import '../../http_requests/http_requests.dart';

class AuthRepositoryImpl extends AuthRepositoryInterface {
  AuthRepositoryImpl();

  @override
  Future<UserModel?> checkAccountLocally() async {
    final result = main.userBox.get('user');
    return result;
  }

  @override
  Future<bool?> checkUsernameExistence({required String username}) async {
    final response = await CheckUsernameExistenceRequest.send(username: username);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      final isUsernameFree = (decodedResponse as bool);
      final isUsernameAlreadyExists = !isUsernameFree;
      return isUsernameAlreadyExists;
    }
    return null;
  }

  @override
  Future<UserModel?> refreshJWT() async {
    final response = await RefreshJWTRequest.send(jwt: main.userBox.get('user')?.accessToken);
    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      final UserModel user = UserModel.fromJson(
        user: decodedResponse["user"],
        jwt: decodedResponse["jwt"],
      );
      main.userBox.put("user", user);
      final result = main.userBox.get('user');
      return result;
    } else {
      return null;
    }
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
      main.userBox.put("user", user);
      final result = main.userBox.get('user');
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
      main.userBox.put("user", user);
      final result = main.userBox.get('user');
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    main.userBox.clear();
    return;
  }
}
