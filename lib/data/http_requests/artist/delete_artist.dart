import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class DeleteArtistRequest {
  //
  static Future<http.Response> send({
    required int artistId,
  }) async {
    return await http.delete(
      Uri.parse("${BackendConfig.baseUrl}/artist/$artistId"),
      headers: BackendConfig.baseHeaders,
    );
  }
}
