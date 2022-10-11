import 'dart:convert';

import 'package:http/http.dart' as http;

import '../backend_config/backend_config.dart';

class VerifyCodeRequest {
  //
  static Future<http.Response> send({
    required String email,
    required String code,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/user/verify"),
      body: jsonEncode({
        "phone": email,
        "token": code,
      }),
      headers: BackendConfig.baseHeaders,
    );
  }
}
