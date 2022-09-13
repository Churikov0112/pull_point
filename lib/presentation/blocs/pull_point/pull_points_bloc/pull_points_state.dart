part of 'pull_points_bloc.dart';

abstract class PullPointsState extends Equatable {
  const PullPointsState();

  @override
  List<Object> get props => [];
}

class PullPointsStateInitial extends PullPointsState {}

class PullPointsStateLoading extends PullPointsState {}

class PullPointsStateLoaded extends PullPointsState {
  final List<PullPointModel> pullPoints;

  const PullPointsStateLoaded({
    required this.pullPoints,
  });

  @override
  List<Object> get props => [pullPoints];
}

class PullPointsStateSelected extends PullPointsState {
  final List<PullPointModel> otherPullPoints;
  final PullPointModel selectedPullPoint;

  const PullPointsStateSelected({
    required this.selectedPullPoint,
    required this.otherPullPoints,
  });

  @override
  List<Object> get props => [otherPullPoints, selectedPullPoint];
}

class PullPointsStateFailed extends PullPointsState {
  final String errorMessage;

  const PullPointsStateFailed({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
