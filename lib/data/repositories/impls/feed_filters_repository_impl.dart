import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

class FeedFiltersRepositoryImpl extends FeedFiltersRepositoryInterface {
  // use as const
  final List<AbstractFilter> _allFilters = [];

  List<AbstractFilter> activeFilters = [];

  @override
  List<AbstractFilter> getAllFeedFilters() {
    return _allFilters;
  }

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
    activeFilters.add(_allFilters.first);
    return activeFilters.first;
  }
}
