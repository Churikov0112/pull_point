part of 'create_pull_point_bloc.dart';

abstract class CreatePullPointState extends Equatable {
  const CreatePullPointState();

  @override
  List<Object> get props => [];
}

class CreatePullPointStateInitial extends CreatePullPointState {
  const CreatePullPointStateInitial();
}

class CreatePullPointStateLoading extends CreatePullPointState {
  const CreatePullPointStateLoading();
}

class CreatePullPointStateCreated extends CreatePullPointState {
  const CreatePullPointStateCreated();
}

class CreatePullPointStateFailed extends CreatePullPointState {
  const CreatePullPointStateFailed();
}
