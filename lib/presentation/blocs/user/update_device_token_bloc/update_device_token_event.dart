part of 'update_device_token_bloc.dart';

abstract class UpdateDeviceTokenEvent extends Equatable {
  const UpdateDeviceTokenEvent();

  @override
  List<Object> get props => [];
}

class UpdateDeviceTokenEventUpdate extends UpdateDeviceTokenEvent {
  final String deviceToken;

  const UpdateDeviceTokenEventUpdate({
    required this.deviceToken,
  });
}
