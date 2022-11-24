import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class GetUserWalletRequest {
  //
  static Future<http.Response> send({
    required String? jwt,
  }) async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/wallet"),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
