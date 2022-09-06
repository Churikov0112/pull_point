import '../../models/models.dart';

abstract class FeedFiltersRepositoryInterface {
  Map<String, AbstractFilter?> getActiveFeedFilters();

  Map<String, AbstractFilter?> resetFeedFilters();

  Map<String, AbstractFilter?> saveFeedFilters({
    required Map<String, AbstractFilter?> filters,
  });
}
