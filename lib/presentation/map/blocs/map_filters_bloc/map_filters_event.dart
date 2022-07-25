part of 'map_filters_bloc.dart';

abstract class MapFiltersEvent extends Equatable {
  const MapFiltersEvent();

  @override
  List<Object> get props => [];
}

class SetMapFiltersEvent extends MapFiltersEvent {
  final List<AbstractFilter> filters;

  const SetMapFiltersEvent({
    required this.filters,
  });
}

class ResetMapFiltersEvent extends MapFiltersEvent {
  const ResetMapFiltersEvent();
}
