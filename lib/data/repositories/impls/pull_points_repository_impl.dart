import 'package:latlong2/latlong.dart';
import 'package:pull_point/domain/models/geo/geo.dart';

import '../../../domain/domain.dart';
import '../../../main.dart' as main;
import '../../http_requests/http_requests.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  PullPointsRepositoryImpl();

  List<PullPointModel> allPullPoints = [];

  List<PullPointModel> mocks = [
    PullPointModel(
      id: 0,
      title: "title",
      description: "description",
      category: const CategoryModel(id: 0, name: "cat0"),
      subcategories: const [
        SubcategoryModel(id: 11, name: "subcat11"),
        SubcategoryModel(id: 22, name: "subcat22"),
      ],
      geo: Geo(latLng: LatLng(59.936521, 30.500014)),
      startsAt: DateTime.now(),
      endsAt: DateTime.now().add(const Duration(hours: 2)),
      owner: const ArtistModel(
        id: 0,
        name: "artist1",
        description: "+79643407137",
        category: CategoryModel(id: 0, name: "cat0"),
        subcategories: [
          SubcategoryModel(id: 11, name: "subcat11"),
          SubcategoryModel(id: 22, name: "subcat22"),
        ],
      ),
      artists: const [],
      nearestMetroStations: [
        MetroStationModel(
          id: 94,
          title: "Ладожская",
          latLng: LatLng(60.11994, 31.07377),
          line: MetroLines.fourthOrange,
        ),
        MetroStationModel(
          id: 95,
          title: "Большевиков",
          latLng: LatLng(59.895, 30.49139),
          line: MetroLines.fourthOrange,
        ),
      ],
    ),
  ];

  @override
  Future<List<PullPointModel>> getPullPoints({
    required bool needUpdate,
  }) async {
    // if (needUpdate) {
    //   final response = await GetPullPointsRequest.send();
    //   String source = const Utf8Decoder().convert(response.bodyBytes);
    //   final decodedResponse = jsonDecode(source);
    //   // print(decodedResponse);
    //   allPullPoints.clear();
    //   for (final element in decodedResponse) {
    //     allPullPoints.add(PullPointModel.fromJson(element));
    //   }
    // } else {
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

    allPullPoints.addAll(mocks);
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
