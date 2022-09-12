import 'dart:convert';
import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class CreateUserRequest {
  //
  static Future<http.Response> send({
    required int id,
    required String username,
    required String email,
  }) async {
    return await http.put(
      Uri.parse("${BackendConfig.baseUrl}/user"),
      body: jsonEncode({
        "id": id,
        "username": username,
        "phone": email,
      }),
      headers: BackendConfig.baseHeaders,
    );
  }
}
