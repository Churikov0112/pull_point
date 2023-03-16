import 'package:http/http.dart' as http;

import '../backend_config/backend_config.dart';

class GetPullPointsRequest {
  //
  static Future<http.Response> send() async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/pull-point"),
      headers: BackendConfig.baseHeaders,
    );
  }
}
