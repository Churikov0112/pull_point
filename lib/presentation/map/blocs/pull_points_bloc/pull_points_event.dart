part of 'pull_points_bloc.dart';

abstract class PullPointsEvent extends Equatable {
  const PullPointsEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends PullPointsEvent {}

class SelectPullPointEvent extends PullPointsEvent {
  const SelectPullPointEvent({
    required this.selectedPullPointId,
  });

  final int selectedPullPointId;
}

class UnselectPullPointEvent extends PullPointsEvent {}
