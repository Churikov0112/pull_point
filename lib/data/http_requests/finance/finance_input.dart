import 'dart:convert';

import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class FinanceInputRequest {
  //
  static Future<http.Response> send({
    required int sum,
    required String? jwt,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/finance/input"),
      body: jsonEncode({
        "sum": sum,
      }),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
