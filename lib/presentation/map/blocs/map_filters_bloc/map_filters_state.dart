part of 'map_filters_bloc.dart';

abstract class MapFiltersState extends Equatable {
  const MapFiltersState();

  @override
  List<Object> get props => [];
}

class MapFiltersInitialState extends MapFiltersState {
  const MapFiltersInitialState();
}

class MapFiltersFilteredState extends MapFiltersState {
  final DateTimeFilter dateTimeFilter;

  const MapFiltersFilteredState({
    required this.dateTimeFilter,
  });

  @override
  List<Object> get props => [dateTimeFilter];
}
