import 'dart:convert';
import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class CreateArtistRequest {
  //
  static Future<http.Response> send({
    required String name,
    required String description,
    required int categoryId,
    required int userId,
    required List<int>? subcategoriesIds,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/artist"),
      headers: BackendConfig.baseHeaders,
      body: jsonEncode(
        {
          "subcategories": subcategoriesIds,
          "name": name,
          "description": description,
          "category": categoryId,
          "owner": userId,
        },
      ),
    );
  }
}
