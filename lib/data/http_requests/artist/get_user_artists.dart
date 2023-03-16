import 'package:http/http.dart' as http;

import '../backend_config/backend_config.dart';

class GetUserArtistsRequest {
  //
  static Future<http.Response> send({
    required int userId,
  }) async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/artist/by-user/$userId"),
      headers: BackendConfig.baseHeaders,
    );
  }
}
