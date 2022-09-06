import 'package:flutter/material.dart';
import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';

class MapFiltersRepositoryImpl extends MapFiltersRepositoryInterface {
  // use as const
  final List<AbstractFilter> _allFilters = [];

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
