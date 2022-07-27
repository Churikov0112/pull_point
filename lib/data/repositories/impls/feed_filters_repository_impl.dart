import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

class FeedFiltersRepositoryImpl extends FeedFiltersRepositoryInterface {
  // use as const
  final List<AbstractFilter> _allFilters = [
    // DateTimeFilter(
    //   dateRange: DateTimeRange(
    //     start: DateTime.now(),
    //     end: DateTime.now().add(const Duration(days: 0)),
    //   ),
    //   timeRange: TimeRange(
    //     startTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    //     endTime: const TimeOfDay(hour: 23, minute: 59),
    //   ),
    // ),
  ];

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