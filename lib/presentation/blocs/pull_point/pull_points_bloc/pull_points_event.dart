part of 'pull_points_bloc.dart';

abstract class PullPointsEvent {
  const PullPointsEvent();
}

class PullPointsEventLoad extends PullPointsEvent {
  const PullPointsEventLoad();
}

class SelectPullPointEvent extends PullPointsEvent {
  final int selectedPullPointId;

  const SelectPullPointEvent({
    required this.selectedPullPointId,
  });
}

class UnselectPullPointEvent extends PullPointsEvent {
  const UnselectPullPointEvent();
}
