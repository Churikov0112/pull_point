import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'pull_points_event.dart';
part 'pull_points_state.dart';

class PullPointsBloc extends Bloc<PullPointsEvent, PullPointsState> {
  final PullPointsRepositoryInterface _pullPointsRepositoryInterface;

  PullPointsBloc({
    required PullPointsRepositoryInterface pullPointsRepositoryInterface,
  })  : _pullPointsRepositoryInterface = pullPointsRepositoryInterface,
        super(InitialState()) {
    on<LoadEvent>(_loadData);
  }

  Future<void> _loadData(LoadEvent event, Emitter<PullPointsState> emit) async {
    try {
      emit(LoadingState());
      // call method in repository
      // pullPoints = await _repository.getPullPoints();
      // emit(LoadedState(pullPoints: pullPoints));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }
}
