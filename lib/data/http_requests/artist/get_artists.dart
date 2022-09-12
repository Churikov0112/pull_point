import 'dart:convert';
import 'package:http/http.dart' as http;
import '../backend_config/backend_config.dart';

class GetArtistsRequest {
  //
  static Future<http.Response> send({
    required String? search,
    required int? categoryId,
    required List<int>? subcategoryIds,
  }) async {
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/artist/filter"),
      headers: BackendConfig.baseHeaders,
      body: jsonEncode(
        {
          "name": search,
          "category": categoryId,
          "subcategories": subcategoryIds,
        },
      ),
    );
  }
}
