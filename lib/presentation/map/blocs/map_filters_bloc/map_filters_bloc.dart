import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'map_filters_event.dart';
part 'map_filters_state.dart';

class MapFiltersBloc extends Bloc<MapFiltersEvent, MapFiltersState> {
  final MapFiltersRepositoryInterface _mapFiltersRepository;
  // final PullPointsRepositoryInterface _pullPointsRepository;

  MapFiltersBloc({
    required MapFiltersRepositoryInterface mapFiltersRepository,
    // required PullPointsRepositoryInterface pullPointsRepository,
  })  : _mapFiltersRepository = mapFiltersRepository,
        // _pullPointsRepository = pullPointsRepository,
        super(const MapFiltersInitialState()) {
    on<SetMapFiltersEvent>(_setFilters);
    on<ResetMapFiltersEvent>(_resetFilters);
  }

  void _setFilters(SetMapFiltersEvent event, Emitter<MapFiltersState> emit) {
    final mapFilters = _mapFiltersRepository.saveMapFilters(filters: event.filters);
    emit(MapFiltersFilteredState(dateTimeFilter: mapFilters.first as DateTimeFilter));
  }

  void _resetFilters(ResetMapFiltersEvent event, Emitter<MapFiltersState> emit) {
    final defaultDateTimeFilter = _mapFiltersRepository.resetMapFilters();
    emit(MapFiltersFilteredState(dateTimeFilter: defaultDateTimeFilter as DateTimeFilter));
  }
}
