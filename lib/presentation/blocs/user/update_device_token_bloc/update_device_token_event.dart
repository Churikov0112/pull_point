part of 'update_device_token_bloc.dart';

abstract class UpdateDeviceTokenEvent {
  const UpdateDeviceTokenEvent();
}

class UpdateDeviceTokenEventUpdate extends UpdateDeviceTokenEvent {
  final String deviceToken;

  const UpdateDeviceTokenEventUpdate({
    required this.deviceToken,
  });
}
