import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';
import '../../config/config.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  List<PullPointModel> allPullPoints = [];

  @override
  Future<List<PullPointModel>> getPullPoints() async {
    try {
      if (allPullPoints.isEmpty) {
        final response = await http.get(Uri.parse("${BackendConfig.baseUrl}/guest/pull_points"));
        String source = const Utf8Decoder().convert(response.bodyBytes);

        final decodedResponse = jsonDecode(source);

        allPullPoints.clear();

        for (final element in decodedResponse) {
          allPullPoints.add(PullPointModel.fromJson(element));
        }
      }
    } catch (e) {
      print(e);
    }
    return allPullPoints;
  }

  @override
  Future<bool> createPullPoint({
    required String name,
    required String description,
    required int ownerId,
    required double latitude,
    required double longitude,
    required DateTime startTime,
    required DateTime endTime,
    required int categoryId,
    List<int>? subcategoryIds,
  }) async {
    print("ownerId: $ownerId");
    final response = await http.post(
      Uri.parse("${BackendConfig.baseUrl}/artist/pull_point"),
      body: jsonEncode(
        {
          "owner": ownerId,
          "name": name,
          "description": description,
          "latitude": latitude,
          "longitude": longitude,
          "startTime": DateFormat("dd.MM.yyyy:HH.mm").format(startTime),
          "endTime": DateFormat("dd.MM.yyyy:HH.mm").format(endTime),
          "category": categoryId,
          "subcategories": subcategoryIds
        },
      ),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    print('response ${response.body}');
    if (response.statusCode == 200) return true;
    return false;
  }
}
