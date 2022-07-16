import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'pull_points_event.dart';
part 'pull_points_state.dart';

class PullPointsBloc extends Bloc<PullPointsEvent, PullPointsState> {
  final PullPointsRepositoryInterface _repository;

  PullPointsBloc({
    required PullPointsRepositoryInterface repository,
  })  : _repository = repository,
        super(InitialState()) {
    on<LoadDataEvent>(_loadData);
    on<SelectPullPointEvent>(_select);
    on<UnselectPullPointEvent>(_unselect);
  }

  Future<void> _loadData(LoadDataEvent event, Emitter<PullPointsState> emit) async {
    try {
      emit(LoadingState());
      final pullPoints = await _repository.getPullPoints();
      emit(LoadedState(pullPoints: pullPoints));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _select(SelectPullPointEvent event, Emitter<PullPointsState> emit) async {
    try {
      final pullPoints = await _repository.getPullPoints();
      final selectedPullPoint = pullPoints.firstWhere((pp) => pp.id == event.selectedPullPointId);
      final otherPullPoints = await _repository.getPullPoints();
      emit(SelectedState(selectedPullPoint: selectedPullPoint, otherPullPoints: otherPullPoints));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _unselect(UnselectPullPointEvent event, Emitter<PullPointsState> emit) async {
    try {
      final pullPoints = await _repository.getPullPoints();
      emit(LoadedState(pullPoints: pullPoints));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }
}
