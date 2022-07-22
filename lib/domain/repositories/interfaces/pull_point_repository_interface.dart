import '../../models/models.dart';

abstract class PullPointsRepositoryInterface {
  Future<List<PullPointModel>> getPullPoints({
    DateTimeFilter? dateTimeFilter,
  });
}
