part of 'pull_points_bloc.dart';

abstract class PullPointsState extends Equatable {
  const PullPointsState();

  @override
  List<Object> get props => [];
}

class InitialState extends PullPointsState {}

class LoadingState extends PullPointsState {}

class LoadedState extends PullPointsState {
  final List<PullPointModel> pullPoints;

  const LoadedState({
    required this.pullPoints,
  });
}

class SelectedState extends PullPointsState {
  final List<PullPointModel> otherPullPoints;
  final PullPointModel selectedPullPoint;

  const SelectedState({
    required this.selectedPullPoint,
    required this.otherPullPoints,
  });
}

class FailedState extends PullPointsState {
  final String errorMessage;

  const FailedState({
    required this.errorMessage,
  });
}
