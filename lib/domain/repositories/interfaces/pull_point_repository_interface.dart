import '../../models/models.dart';

abstract class PullPointsRepositoryInterface {
  Future<List<PullPointModel>> getPullPoints();

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
  });
}
