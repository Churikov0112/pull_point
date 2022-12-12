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
        super(PullPointsStateInitial()) {
    on<PullPointsEventLoad>(_loadData);
    on<SelectPullPointEvent>(_select);
    on<UnselectPullPointEvent>(_unselect);
  }

  Future<void> _loadData(PullPointsEventLoad event, Emitter<PullPointsState> emit) async {
    try {
      emit(PullPointsStateLoading());
      await Future.delayed(const Duration(seconds: 1));
      final pullPoints = await _repository.getPullPoints(needUpdate: true);
      emit(PullPointsStateLoaded(pullPoints: pullPoints));
    } catch (e) {
      emit(PullPointsStateFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _select(SelectPullPointEvent event, Emitter<PullPointsState> emit) async {
    try {
      final pullPoints = await _repository.getPullPoints(needUpdate: false);
      final selectedPullPoint = pullPoints.firstWhere((pp) => pp.id == event.selectedPullPointId);
      final List<PullPointModel> otherPullPoints = [];
      for (final pp in pullPoints) {
        if (pp.id != event.selectedPullPointId) {
          otherPullPoints.add(pp);
        }
      }
      emit(PullPointsStateSelected(selectedPullPoint: selectedPullPoint, otherPullPoints: otherPullPoints));
    } catch (e) {
      emit(PullPointsStateFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _unselect(UnselectPullPointEvent event, Emitter<PullPointsState> emit) async {
    try {
      final pullPoints = await _repository.getPullPoints(needUpdate: false);
      emit(PullPointsStateLoaded(pullPoints: pullPoints));
    } catch (e) {
      emit(PullPointsStateFailed(errorMessage: e.toString()));
    }
  }
}
