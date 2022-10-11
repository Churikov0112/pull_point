import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../backend_config/backend_config.dart';

class CreatePullPointRequest {
  //
  static Future<http.Response> send({
    required int ownerId,
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required DateTime startTime,
    required DateTime endTime,
    required int categoryId,
    required List<int>? subcategoryIds,
    required String? jwt,
  }) async {
    // print({
    //   "owner": ownerId,
    //   "artists": [],
    //   "name": name,
    //   "description": description,
    //   "latitude": latitude,
    //   "longitude": longitude,
    //   "startTime": DateFormat("dd.MM.yyyy:HH.mm").format(startTime),
    //   "endTime": DateFormat("dd.MM.yyyy:HH.mm").format(endTime),
    //   "category": categoryId,
    //   "subcategories": subcategoryIds
    // });
    return await http.post(
      Uri.parse("${BackendConfig.baseUrl}/pull_point"),
      body: jsonEncode({
        "owner": ownerId,
        "name": name,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "startTime": DateFormat("dd.MM.yyyy:HH.mm").format(startTime),
        "endTime": DateFormat("dd.MM.yyyy:HH.mm").format(endTime),
        "category": categoryId,
        "artists": [],
        "subcategories": subcategoryIds
      }),
      headers: BackendConfig.baseHeadersWithToken(jwt: jwt),
    );
  }
}
