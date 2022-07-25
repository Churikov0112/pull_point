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
  final DateTimeFilter dateTimeFilter;

  const FeedFiltersFilteredState({
    required this.dateTimeFilter,
  });

  @override
  List<Object> get props => [dateTimeFilter];
}
