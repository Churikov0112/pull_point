part of 'update_device_token_bloc.dart';

abstract class UpdateDeviceTokenState extends Equatable {
  const UpdateDeviceTokenState();

  @override
  List<Object> get props => [];
}

class UpdateDeviceTokenStateInitial extends UpdateDeviceTokenState {
  const UpdateDeviceTokenStateInitial();
}

class UpdateDeviceTokenStatePending extends UpdateDeviceTokenState {
  const UpdateDeviceTokenStatePending();
}

class UpdateDeviceTokenStateUpdated extends UpdateDeviceTokenState {
  const UpdateDeviceTokenStateUpdated();
}

class UpdateDeviceTokenStateFailed extends UpdateDeviceTokenState {
  const UpdateDeviceTokenStateFailed();
}
