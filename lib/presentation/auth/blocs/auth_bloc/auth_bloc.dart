import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/repositories/repositories.dart';

import '../../../../domain/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryInterface _authRepositoryInterface;

  AuthBloc({
    required AuthRepositoryInterface authRepositoryImpl,
  })  : _authRepositoryInterface = authRepositoryImpl,
        super(const AuthStateUnauthorized()) {
    on<AuthEventCheckAccoutLocally>(_checkAccountLocally);
    on<AuthEventSendCode>(_sendVerificationCode);
    on<AuthEventLogin>(_login);
    on<AuthEventRegister>(_register);
    on<AuthEventLogout>(_logout);
    on<AuthEventContinueAsGuest>(_continueAsGuest);
  }

  Future<void> _continueAsGuest(AuthEventContinueAsGuest event, Emitter<AuthState> emit) async {
    emit(const AuthStateGuest());
  }

  Future<void> _checkAccountLocally(AuthEventCheckAccoutLocally event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final UserModel? user = await _authRepositoryInterface.checkAccountLocally();
    if (user != null) {
      emit(AuthStateAuthorized(user: user));
    } else {
      emit(const AuthStateUnauthorized());
    }
  }

  Future<void> _sendVerificationCode(AuthEventSendCode event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final sent = await _authRepositoryInterface.sendVerificationCode(email: event.email);
    if (sent) {
      emit(AuthStateCodeSent(email: event.email));
    } else {
      emit(const AuthStateUnauthorized());
    }
  }

  Future<void> _login(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final user = await _authRepositoryInterface.login(email: event.email, code: event.code);
    if (user != null) {
      if (user.username != null) {
        emit(AuthStateAuthorized(user: user));
      } else {
        emit(AuthStateCodeVerified(id: user.id, email: user.email, code: event.code, username: user.username));
      }
    } else {
      emit(const AuthStateUnauthorized());
      BotToast.showText(text: "Неверный код, попробуйте снова");
    }
  }

  Future<void> _register(AuthEventRegister event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final user = await _authRepositoryInterface.register(id: event.id, email: event.email, username: event.username);
    if (user != null) {
      emit(AuthStateAuthorized(user: user));
    } else {
      emit(const AuthStateUnauthorized());
      BotToast.showText(text: "Ошибка регистрации, попробуйте снова");
    }
  }

  Future<void> _logout(AuthEventLogout event, Emitter<AuthState> emit) async {
    await _authRepositoryInterface.logout();
    emit(const AuthStateUnauthorized());
  }
}
