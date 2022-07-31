import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

class FeedFiltersRepositoryImpl extends FeedFiltersRepositoryInterface {
  List<AbstractFilter> activeFilters = [];

  @override
  List<AbstractFilter> getActiveFeedFilters() {
    return activeFilters;
  }

  @override
  List<AbstractFilter> saveFeedFilters({
    required List<AbstractFilter> filters,
  }) {
    activeFilters = filters;
    return activeFilters;
  }

  @override
  AbstractFilter resetFeedFilters() {
    activeFilters.clear();
    return activeFilters.first;
  }
}
