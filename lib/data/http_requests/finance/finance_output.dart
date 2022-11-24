import 'dart:convert';

import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class FinanceOutputRequest {
  //
  static Future<http.Response> send({
    required int sum,
    required String outputCardNumber,
    required String? jwt,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/finance/output"),
      body: jsonEncode({
        "sum": sum,
        "credentials": outputCardNumber,
      }),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
