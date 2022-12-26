import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class DeleteArtistFromUserFavoritesRequest {
  //
  static Future<http.Response> send({
    required int artistId,
    required String? jwt,
  }) async {
    return await http.delete(
      Uri.parse("${BackendConfig.baseUrl}/favs/$artistId"),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
