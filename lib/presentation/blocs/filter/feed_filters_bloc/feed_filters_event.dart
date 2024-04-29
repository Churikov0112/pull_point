part of 'feed_filters_bloc.dart';

abstract class FeedFiltersEvent {
  const FeedFiltersEvent();
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
