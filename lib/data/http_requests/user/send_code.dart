import 'dart:convert';

import 'package:http/http.dart' as http;

import '../backend_config/backend_config.dart';

class SendCodeRequest {
  //
  static Future<http.Response> send({
    required String email,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/user/code"),
      body: jsonEncode({
        "phone": email,
      }),
      headers: BackendConfig.baseHeaders,
    );
  }
}
