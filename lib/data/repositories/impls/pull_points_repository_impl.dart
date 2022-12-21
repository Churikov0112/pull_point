import 'dart:convert';

import '../../../domain/domain.dart';
import '../../../main.dart' as main;
import '../../http_requests/http_requests.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  PullPointsRepositoryImpl();

  List<PullPointModel> allPullPoints = [];

  @override
  Future<List<PullPointModel>> getPullPoints({
    required bool needUpdate,
  }) async {
    if (needUpdate) {
      // загружаем в любом случае
      final response = await GetPullPointsRequest.send();
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      // print(decodedResponse);
      allPullPoints.clear();
      for (final element in decodedResponse) {
        allPullPoints.add(PullPointModel.fromJson(element));
      }
    } else {
      // загружаем только в случае отсутствия пулл поинтов
      if (allPullPoints.isEmpty) {
        final response = await GetPullPointsRequest.send();
        String source = const Utf8Decoder().convert(response.bodyBytes);
        final decodedResponse = jsonDecode(source);
        allPullPoints.clear();
        for (final element in decodedResponse) {
          allPullPoints.add(PullPointModel.fromJson(element));
        }
      }
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
    final response = await CreatePullPointRequest.send(
      ownerId: ownerId,
      name: name,
      description: description,
      latitude: latitude,
      longitude: longitude,
      startTime: startTime,
      endTime: endTime,
      categoryId: categoryId,
      subcategoryIds: subcategoryIds,
      jwt: main.userBox.get("user")?.accessToken,
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
