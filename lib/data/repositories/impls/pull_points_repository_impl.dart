import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:pull_point/domain/models/geo/geo.dart';

import '../../../domain/domain.dart';
import '../../http_requests/http_requests.dart';
import '../mock/metro_stations.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  PullPointsRepositoryImpl({
    required this.userBox,
  });

  List<PullPointModel> allPullPoints = [];
  Box<UserModel?> userBox;

  @override
  Future<List<PullPointModel>> getPullPoints({
    required bool needUpdate,
  }) async {
    // TODO раскомментировать
    // if (needUpdate) {
    //   // загружаем в любом случае
    //   final response = await GetPullPointsRequest.send();
    //   String source = const Utf8Decoder().convert(response.bodyBytes);
    //   final decodedResponse = jsonDecode(source);
    //   // print(decodedResponse);
    //   allPullPoints.clear();
    //   for (final element in decodedResponse) {
    //     allPullPoints.add(PullPointModel.fromJson(element));
    //   }
    // } else {
    //   // загружаем только в случае отсутствия пулл поинтов
    //   if (allPullPoints.isEmpty) {
    //     final response = await GetPullPointsRequest.send();
    //     String source = const Utf8Decoder().convert(response.bodyBytes);
    //     final decodedResponse = jsonDecode(source);
    //     allPullPoints.clear();
    //     for (final element in decodedResponse) {
    //       allPullPoints.add(PullPointModel.fromJson(element));
    //     }
    //   }
    // }

    allPullPoints = [
      PullPointModel(
        id: 0,
        title: "Стрит на грибе",
        description: "Глеб Васильев ебанулся и играет фонк",
        category: const CategoryModel(id: 0, name: "Музыка"),
        subcategories: const [
          SubcategoryModel(id: 22, name: "Фонк"),
        ],
        geo: Geo(latLng: LatLng(59.9351, 30.328573)),
        startsAt: DateTime.now(),
        endsAt: DateTime.now().add(const Duration(hours: 4)),
        owner: const ArtistModel(
          id: 0,
          name: "Cheap Dramas",
          description: "lkakk;lkakkflkakklkakklkakklkakklkakklkakklkakklkakklkakklkakklkakklkakklkakklkakklkakklkakk",
          category: CategoryModel(id: 0, name: "Музыка"),
          subcategories: [
            SubcategoryModel(id: 20, name: "Рэп"),
            SubcategoryModel(id: 21, name: "Стрит"),
            SubcategoryModel(id: 22, name: "Фонк"),
          ],
        ),
        artists: const [],
        nearestMetroStations: MetroStations.getNearestMetroStations(latLng: LatLng(59.9351, 30.328573)),
      ),
    ];

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
      jwt: userBox.get("user")?.accessToken,
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
