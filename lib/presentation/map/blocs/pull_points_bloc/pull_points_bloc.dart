import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'pull_points_event.dart';
part 'pull_points_state.dart';

class PullPointsBloc extends Bloc<PullPointsEvent, PullPointsState> {
  final PullPointsRepositoryInterface _repository;
  final MetroStationsRepositoryInterface _metroStationsRepository;

  PullPointsBloc({
    required PullPointsRepositoryInterface repository,
    required MetroStationsRepositoryInterface metroStationsRepository,
  })  : _repository = repository,
        _metroStationsRepository = metroStationsRepository,
        super(InitialState()) {
    on<LoadDataEvent>(_loadData);
    on<SelectPullPointEvent>(_select);
    on<UnselectPullPointEvent>(_unselect);
  }

  Future<void> _loadData(LoadDataEvent event, Emitter<PullPointsState> emit) async {
    try {
      emit(LoadingState());
      final pullPoints = await _repository.getPullPoints();
      final metroStations = _metroStationsRepository.getAllMetroStations();
      emit(LoadedState(pullPoints: pullPoints, metroStations: metroStations));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _select(SelectPullPointEvent event, Emitter<PullPointsState> emit) async {
    try {
      final pullPoints = await _repository.getPullPoints();
      final selectedPullPoint = pullPoints.firstWhere((pp) => pp.id == event.selectedPullPointId);
      final List<PullPointModel> otherPullPoints = [];
      for (final pp in pullPoints) {
        if (pp.id != event.selectedPullPointId) {
          otherPullPoints.add(pp);
        }
      }
      final metroStations = _metroStationsRepository.getNearestMetroStations(latLng: selectedPullPoint.latLng);
      emit(SelectedState(selectedPullPoint: selectedPullPoint, otherPullPoints: otherPullPoints, metroStations: metroStations));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _unselect(UnselectPullPointEvent event, Emitter<PullPointsState> emit) async {
    try {
      final pullPoints = await _repository.getPullPoints();
      final metroStations = _metroStationsRepository.getAllMetroStations();
      emit(LoadedState(pullPoints: pullPoints, metroStations: metroStations));
    } catch (e) {
      emit(FailedState(errorMessage: e.toString()));
    }
  }
}
