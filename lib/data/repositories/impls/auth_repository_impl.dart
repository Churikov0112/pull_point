import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepositoryInterface {
  @override
  Future<UserModel?> checkAccountLocally() async {
    final userBox = await Hive.openBox<UserModel>('user_box');
    final result = userBox.get('user_data');
    return result;
  }

  @override
  Future<bool> sendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://www.pullpoint.ru:2022/auth/sendToken"),
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
      Uri.parse("http://www.pullpoint.ru:2022/auth/verify"),
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
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> register({
    required int id,
    required String email,
    required String username,
  }) async {
    final response = await http.put(
      Uri.parse("http://www.pullpoint.ru:2022/auth/register"),
      body: jsonEncode({"id": id, "username": username, "phone": email}),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final UserModel user = UserModel(id: id, email: email, username: username);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    final userBox = await Hive.openBox<UserModel>('user_box');
    userBox.delete('user_data');
    return;
  }
}
