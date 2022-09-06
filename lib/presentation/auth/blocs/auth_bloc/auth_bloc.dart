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
    on<AuthEventOpenEmailPage>(_openEmailPage);
    on<AuthEventOpenWannaBeArtistPage>(_openWannaBeArtistPage);
    on<AuthEventOpenUpdateArtistPage>(_openUpdateArtistPage);
    on<AuthEventSendCode>(_sendVerificationCode);
    on<AuthEventLogin>(_login);
    on<AuthEventRegisterUser>(_registerUser);
    on<AuthEventRegisterArtist>(_registerArtist);
    on<AuthEventLogout>(_logout);
    on<AuthEventContinueAsGuest>(_continueAsGuest);
  }

  Future<void> _continueAsGuest(AuthEventContinueAsGuest event, Emitter<AuthState> emit) async {
    emit(const AuthStateGuest());
    BotToast.showText(text: "Вы продолжили как гость. Некоторые функции будут недоступны");
  }

  Future<void> _openEmailPage(AuthEventOpenEmailPage event, Emitter<AuthState> emit) async {
    emit(AuthStateEnterEmailPageOpened(email: event.email));
  }

  Future<void> _openWannaBeArtistPage(AuthEventOpenWannaBeArtistPage event, Emitter<AuthState> emit) async {
    emit(AuthStateUsernameInputed(user: event.user));
  }

  Future<void> _openUpdateArtistPage(AuthEventOpenUpdateArtistPage event, Emitter<AuthState> emit) async {
    emit(AuthStateArtistCreating(user: event.user));
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
      BotToast.showText(text: "Не удалось отправить проверочный код");
    }
  }

  Future<void> _login(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final user = await _authRepositoryInterface.login(email: event.email, code: event.code);
    if (user != null) {
      if (user.username != null) {
        emit(AuthStateAuthorized(user: user));
      } else {
        emit(AuthStateCodeVerified(user: user));
      }
    } else {
      BotToast.showText(text: "Неверный код, попробуйте снова");
    }
  }

  Future<void> _registerUser(AuthEventRegisterUser event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final user = await _authRepositoryInterface.updateUser(userInput: event.user);
    if (user != null) {
      emit(AuthStateAuthorized(user: user));
    } else {
      BotToast.showText(text: "Ошибка при создании пользователя");
    }
  }

  Future<void> _registerArtist(AuthEventRegisterArtist event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    final user = await _authRepositoryInterface.updateUser(userInput: event.user);
    final iAmArtist = await _authRepositoryInterface.iAmArtist(userInput: event.user);
    final artist = await _authRepositoryInterface.updateArtist(
      userId: event.user.id,
      name: event.name,
      description: event.description,
      categoryId: event.categoryId,
      subcategoriesIds: event.subcategoryIds,
    );

    if (user != null && iAmArtist && artist != null) emit(AuthStateAuthorized(user: event.user));
    if (artist == null) BotToast.showText(text: "Ошибка при создании артиста");
  }

  Future<void> _logout(AuthEventLogout event, Emitter<AuthState> emit) async {
    await _authRepositoryInterface.logout();
    emit(const AuthStateUnauthorized());
  }
}
