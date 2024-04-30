part of 'update_device_token_bloc.dart';

abstract class UpdateDeviceTokenState {
  const UpdateDeviceTokenState();
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
  final String? reason;

  const UpdateDeviceTokenStateFailed({
    required this.reason,
  });
}
