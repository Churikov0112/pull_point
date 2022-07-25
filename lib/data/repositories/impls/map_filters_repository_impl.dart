import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

class MapFiltersRepositoryImpl extends MapFiltersRepositoryInterface {
  // use as const
  final List<AbstractFilter> _allFilters = [
    DateTimeFilter(
      dateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 0)),
      ),
      timeRange: TimeRange(
        start: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
        end: const TimeOfDay(hour: 23, minute: 59),
      ),
    ),
  ];

  List<AbstractFilter> activeFilters = [];

  @override
  List<AbstractFilter> getAllMapFilters() {
    return _allFilters;
  }

  @override
  List<AbstractFilter> getActiveMapFilters() {
    return activeFilters;
  }

  @override
  List<AbstractFilter> saveMapFilters({
    required List<AbstractFilter> filters,
  }) {
    activeFilters = filters;
    return activeFilters;
  }

  @override
  AbstractFilter resetMapFilters() {
    activeFilters.clear();
    activeFilters.add(_allFilters.first);
    return activeFilters.first;
  }
}
