import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'update_device_token_event.dart';
part 'update_device_token_state.dart';

class UpdateDeviceTokenBloc extends Bloc<UpdateDeviceTokenEvent, UpdateDeviceTokenState> {
  UpdateDeviceTokenBloc({
    required AuthRepositoryInterface authRepository,
  })  : _authRepository = authRepository,
        super(const UpdateDeviceTokenStateInitial()) {
    on<UpdateDeviceTokenEventUpdate>(_update);
  }

  final AuthRepositoryInterface _authRepository;

  Future<void> _update(UpdateDeviceTokenEventUpdate event, Emitter<UpdateDeviceTokenState> emit) async {
    emit(const UpdateDeviceTokenStatePending());
    final success = await _authRepository.updateUserDeviceToken(event.deviceToken);
    if (success) {
      emit(const UpdateDeviceTokenStateUpdated());
      BotToast.showText(text: "device token обновлён");
      return;
    }
    emit(const UpdateDeviceTokenStateFailed());
    BotToast.showText(text: "Не удалось обновить device token");
  }
}
