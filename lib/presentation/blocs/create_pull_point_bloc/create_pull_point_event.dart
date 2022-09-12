part of 'create_pull_point_bloc.dart';

abstract class CreatePullPointEvent extends Equatable {
  const CreatePullPointEvent();

  @override
  List<Object> get props => [];
}

class CreatePullPointEventCreate extends CreatePullPointEvent {
  final String name;
  final String description;
  final int ownerId;
  final double latitude;
  final double longitude;
  final DateTime startTime;
  final DateTime endTime;
  final int categoryId;
  final List<int>? subcategoryIds;

  const CreatePullPointEventCreate({
    required this.name,
    required this.description,
    required this.ownerId,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.endTime,
    required this.categoryId,
    this.subcategoryIds,
  });
}

class CreatePullPointEventReset extends CreatePullPointEvent {}
