part of 'feed_filters_bloc.dart';

abstract class FeedFiltersEvent extends Equatable {
  const FeedFiltersEvent();

  @override
  List<Object> get props => [];
}

class SetFeedFiltersEvent extends FeedFiltersEvent {
  final Map<String, AbstractFilter?> filters;

  const SetFeedFiltersEvent({
    required this.filters,
  });
}

class ResetFeedFiltersEvent extends FeedFiltersEvent {
  const ResetFeedFiltersEvent();
}
