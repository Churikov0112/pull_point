import 'package:latlong2/latlong.dart';
import '../../../domain/domain.dart';

class PullPointsRepositoryImpl extends PullPointsRepositoryInterface {
  List<PullPointModel> allPullPoints = [];

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
          posterUrl: "https://cs4.pikabu.ru/post_img/big/2014/06/01/10/1401638213_127727120.jpg",
        ),
        PullPointModel(
          id: 1,
          title: 'субназвание',
          address: 'где-то в центре СПб',
          createdAt: DateTime.now(),
          expireAt: DateTime.now().add(const Duration(hours: 3)),
          latLng: LatLng(59.9, 30.3),
          artist: const ArtistModel(id: 1, name: 'Банд-М'),
          posterUrl:
              "https://static.wikia.nocookie.net/concerts/images/5/5b/IMG_2886.jpg/revision/latest?cb=20190426122541",
        ),
      ];
    }

    return allPullPoints;
  }
}
