import 'dart:convert';

import 'package:http/http.dart' as http;

import '../backend_config/backend_config.dart';

class UpdateArtistRequest {
  //
  static Future<http.Response> send({
    required String name,
    required String description,
    required int categoryId,
    required int artistId,
    required List<int>? subcategoriesIds,
    required String? jwt,
  }) async {
    return await http.put(
      Uri.parse("${BackendConfig.baseUrl}/artist"),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
      body: jsonEncode({
        "subcategories": subcategoriesIds,
        "name": name,
        "description": description,
        "category": categoryId,
        "id": artistId,
      }),
    );
  }
}
