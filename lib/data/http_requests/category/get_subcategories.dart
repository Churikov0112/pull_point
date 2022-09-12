import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class GetSubcategoriesRequest {
  //
  static Future<http.Response> send({
    required int categoryId,
  }) async {
    return await http.get(
      Uri.parse("${BackendConfig.baseUrl}/category/$categoryId"),
    );
  }
}
