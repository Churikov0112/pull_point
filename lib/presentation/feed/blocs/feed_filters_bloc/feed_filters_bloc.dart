import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'feed_filters_event.dart';
part 'feed_filters_state.dart';

class FeedFiltersBloc extends Bloc<FeedFiltersEvent, FeedFiltersState> {
  final FeedFiltersRepositoryInterface _feedFiltersRepository;

  FeedFiltersBloc({
    required FeedFiltersRepositoryInterface feedFiltersRepository,
  })  : _feedFiltersRepository = feedFiltersRepository,
        super(const FeedFiltersInitialState()) {
    on<SetFeedFiltersEvent>(_setFilters);
    on<ResetFeedFiltersEvent>(_resetFilters);
  }

  void _setFilters(SetFeedFiltersEvent event, Emitter<FeedFiltersState> emit) {
    final feedFilters = _feedFiltersRepository.saveFeedFilters(filters: event.filters);
    emit(FeedFiltersFilteredState(filters: feedFilters));
  }

  void _resetFilters(ResetFeedFiltersEvent event, Emitter<FeedFiltersState> emit) {
    final defaultFilters = _feedFiltersRepository.resetFeedFilters();
    emit(FeedFiltersFilteredState(filters: defaultFilters));
  }
}
