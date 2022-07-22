part of 'pull_points_bloc.dart';

abstract class PullPointsEvent extends Equatable {
  const PullPointsEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends PullPointsEvent {
  final DateTimeFilter? dateTimeFilter;

  const LoadDataEvent({
    this.dateTimeFilter,
  });
}

class SelectPullPointEvent extends PullPointsEvent {
  final int selectedPullPointId;
  final DateTimeFilter? dateTimeFilter;

  const SelectPullPointEvent({
    required this.selectedPullPointId,
    this.dateTimeFilter,
  });
}

class UnselectPullPointEvent extends PullPointsEvent {
  final DateTimeFilter? dateTimeFilter;

  const UnselectPullPointEvent({
    this.dateTimeFilter,
  });
}
