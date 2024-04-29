import 'package:http/http.dart' as http;

import '../../config/backend_config/backend_config.dart';

class GetCategoriesRequest {
  //
  static Future<http.Response> send() async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/category"),
    );
  }
}
