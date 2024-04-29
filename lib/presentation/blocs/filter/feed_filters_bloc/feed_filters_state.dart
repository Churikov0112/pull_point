part of 'feed_filters_bloc.dart';

abstract class FeedFiltersState {
  const FeedFiltersState();
}

class FeedFiltersInitialState extends FeedFiltersState {
  const FeedFiltersInitialState();
}

class FeedFiltersFilteredState extends FeedFiltersState {
  final Map<String, AbstractFilter?> filters;

  const FeedFiltersFilteredState({
    required this.filters,
  });
}
