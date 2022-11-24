import 'dart:convert';

import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class FinanceOutputRequest {
  //
  static Future<http.Response> send({
    required double coinsToOutput,
    required String outputCredentials,
    required String? jwt,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/finance/output"),
      body: jsonEncode({
        "sum": coinsToOutput,
        "credentials": outputCredentials,
      }),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
