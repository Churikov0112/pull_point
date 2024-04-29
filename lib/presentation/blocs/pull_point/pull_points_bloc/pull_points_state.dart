part of 'pull_points_bloc.dart';

abstract class PullPointsState {
  const PullPointsState();
}

class PullPointsStateInitial extends PullPointsState {}

class PullPointsStateLoading extends PullPointsState {}

class PullPointsStateLoaded extends PullPointsState {
  final List<PullPointModel> pullPoints;

  const PullPointsStateLoaded({
    required this.pullPoints,
  });
}

class PullPointsStateSelected extends PullPointsState {
  final List<PullPointModel> otherPullPoints;
  final PullPointModel selectedPullPoint;

  const PullPointsStateSelected({
    required this.selectedPullPoint,
    required this.otherPullPoints,
  });
}

class PullPointsStateFailed extends PullPointsState {
  final String errorMessage;

  const PullPointsStateFailed({
    required this.errorMessage,
  });
}
