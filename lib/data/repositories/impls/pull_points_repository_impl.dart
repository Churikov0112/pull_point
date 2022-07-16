import 'package:latlong2/latlong.dart';
import '../../../domain/domain.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  List<PullPointModel> allPullPoints = [];
  // PullPointModel? selectedPullPoint;

  @override
  Future<List<PullPointModel>> getPullPoints() async {
    // TODO (churikov_egor): remove mock

    if (allPullPoints.isEmpty) {
      print("PullPoints loaded from network");
      allPullPoints = [
        PullPointModel(
          id: 0,
          title: 'title',
          address: 'ст.м. Невский проспект',
          createdAt: DateTime.now(),
          expireAt: DateTime.now().add(const Duration(hours: 2)),
          latLng: LatLng(59.9386, 30.3141),
          artist: const ArtistModel(id: 0, name: 'Космо Кот'),
        ),
        PullPointModel(
          id: 1,
          title: 'субназвание',
          address: 'где-то в центре СПб',
          createdAt: DateTime.now(),
          expireAt: DateTime.now().add(const Duration(hours: 3)),
          latLng: LatLng(59.9, 30.3),
          artist: const ArtistModel(id: 1, name: 'Банд-М'),
        ),
      ];
    }

    return allPullPoints;
  }

  // @override
  // PullPointModel selectPullPoint({
  //   required int pullPointId,
  // }) {
  //   selectedPullPoint = allPullPoints.firstWhere((pp) => pp.id == pullPointId);
  //   return selectedPullPoint!;
  // }

  // @override
  // void unselectPullPoint() {
  //   selectedPullPoint = null;
  // }
}
