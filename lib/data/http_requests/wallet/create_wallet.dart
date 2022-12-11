import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class CreateUserWalletRequest {
  //
  static Future<http.Response> send({
    required String cardNumber,
    required String? jwt,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/wallet/$cardNumber"),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
