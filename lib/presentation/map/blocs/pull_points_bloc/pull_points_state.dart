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

class FailedState extends PullPointsState {
  final String errorMessage;

  const FailedState({
    required this.errorMessage,
  });
}
