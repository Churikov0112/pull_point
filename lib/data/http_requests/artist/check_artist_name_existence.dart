import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class CheckArtistNameExistenceRequest {
  //
  /// true == artistName is free
  /// false == artistName is already exists
  static Future<http.Response> send({
    required String artistName,
  }) async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/user/check/$artistName"),
      headers: BackendConfig.baseHeaders,
    );
  }
}
