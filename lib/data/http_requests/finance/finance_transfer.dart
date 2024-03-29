import 'dart:convert';

import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class FinanceTransferRequest {
  //
  static Future<http.Response> send({
    required String targetArtistName,
    required int sum,
    required String? jwt,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/finance/transfer"),
      body: jsonEncode({
        "artistName": targetArtistName,
        "sum": sum,
      }),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
