import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class CheckUsernameExistenceRequest {
  //
  /// true == username is free
  /// false == username is already exists
  static Future<http.Response> send({
    required String username,
  }) async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/user/check/$username"),
      headers: BackendConfig.baseHeaders,
    );
  }
}
