part of 'pull_points_bloc.dart';

abstract class PullPointsEvent extends Equatable {
  const PullPointsEvent();

  @override
  List<Object> get props => [];
}

class PullPointsEventLoad extends PullPointsEvent {
  const PullPointsEventLoad();
}

class SelectPullPointEvent extends PullPointsEvent {
  final int selectedPullPointId;

  const SelectPullPointEvent({
    required this.selectedPullPointId,
  });

  @override
  List<Object> get props => [selectedPullPointId];
}

class UnselectPullPointEvent extends PullPointsEvent {
  const UnselectPullPointEvent();
}
