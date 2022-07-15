part of 'pull_points_bloc.dart';

abstract class PullPointsEvent extends Equatable {
  const PullPointsEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends PullPointsEvent {}
