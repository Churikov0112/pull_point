part of 'feed_filters_bloc.dart';

abstract class FeedFiltersState extends Equatable {
  const FeedFiltersState();

  @override
  List<Object> get props => [];
}

class FeedFiltersInitialState extends FeedFiltersState {
  const FeedFiltersInitialState();
}

class FeedFiltersFilteredState extends FeedFiltersState {
  final Map<String, AbstractFilter?> filters;

  const FeedFiltersFilteredState({
    required this.filters,
  });

  @override
  List<Object> get props => [filters];
}
