import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

class FeedFiltersRepositoryImpl extends FeedFiltersRepositoryInterface {
  Map<String, AbstractFilter?> activeFilters = {};

  @override
  Map<String, AbstractFilter?> getActiveFeedFilters() {
    return activeFilters;
  }

  @override
  Map<String, AbstractFilter?> saveFeedFilters({
    required Map<String, AbstractFilter?> filters,
  }) {
    activeFilters = filters;
    return activeFilters;
  }

  @override
  Map<String, AbstractFilter?> resetFeedFilters() {
    activeFilters.clear();
    return activeFilters;
  }
}
