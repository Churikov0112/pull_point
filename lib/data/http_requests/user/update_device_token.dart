import 'dart:convert';

import 'package:http/http.dart' as http;

import '../backend_config/backend_config.dart';

class UpdateDeviceTokenRequest {
  //
  static Future<http.Response> send({
    required int? id,
    required String? username,
    required String? phone,
    required String deviceToken,
    required String? jwt,
  }) async {
    return await http.put(
      Uri.parse("${BackendConfig.baseUrl}/user"),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
      body: jsonEncode({
        "id": id,
        "username": username,
        "phone": phone,
        "notificationsToken": deviceToken,
      }),
    );
  }
}
