import '../../models/models.dart';

abstract class MapFiltersRepositoryInterface {
  List<AbstractFilter> getAllMapFilters();

  List<AbstractFilter> getActiveMapFilters();

  AbstractFilter resetMapFilters();

  List<AbstractFilter> saveMapFilters({
    required List<AbstractFilter> filters,
  });
}
