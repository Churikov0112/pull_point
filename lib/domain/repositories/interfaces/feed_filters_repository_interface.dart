import '../../models/models.dart';

abstract class FeedFiltersRepositoryInterface {
  List<AbstractFilter> getActiveFeedFilters();

  AbstractFilter resetFeedFilters();

  List<AbstractFilter> saveFeedFilters({
    required List<AbstractFilter> filters,
  });
}
