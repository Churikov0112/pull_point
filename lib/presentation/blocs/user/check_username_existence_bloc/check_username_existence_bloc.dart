import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'check_username_existence_event.dart';
part 'check_username_existence_state.dart';

class CheckUsernameExistenceBloc extends Bloc<CheckUsernameExistenceEvent, CheckUsernameExistenceState> {
  CheckUsernameExistenceBloc({
    required AuthRepositoryInterface authRepository,
  })  : _authRepository = authRepository,
        super(const CheckUsernameExistenceStateInitial()) {
    on<CheckUsernameExistenceEventCheck>(_checkUsernameExistence);
    on<CheckUsernameExistenceEventReset>(_reset);
  }

  final AuthRepositoryInterface _authRepository;

  Future<void> _checkUsernameExistence(
      CheckUsernameExistenceEventCheck event, Emitter<CheckUsernameExistenceState> emit) async {
    emit(const CheckUsernameExistenceStatePending());
    final exists = await _authRepository.checkUsernameExistence(username: event.username);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (exists == null) {
      BotToast.showText(text: "Произошла ошибка при проверке имени пользователя");
      emit(const CheckUsernameExistenceStateInitial());
      return;
    }
    if (exists) {
      BotToast.showText(text: "Пользователь с таким именем уже существует");
      emit(const CheckUsernameExistenceStateExists());
      return;
    } else {
      emit(const CheckUsernameExistenceStateNotExists());
      return;
    }
  }

  Future<void> _reset(CheckUsernameExistenceEventReset event, Emitter<CheckUsernameExistenceState> emit) async {
    emit(const CheckUsernameExistenceStateInitial());
  }
}
