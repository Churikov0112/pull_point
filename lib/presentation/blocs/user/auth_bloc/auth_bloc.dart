import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/repositories/repositories.dart';

import '../../../../domain/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryInterface _authRepository;
  final ArtistsRepositoryInterface _artistsRepository;

  AuthBloc({
    required AuthRepositoryInterface authRepository,
    required ArtistsRepositoryInterface artistsRepository,
  })  : _authRepository = authRepository,
        _artistsRepository = artistsRepository,
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
    await Future.delayed(const Duration(milliseconds: 1000));
    final UserModel? user = await _authRepository.checkAccountLocally();
    if (user != null) {
      await Future.delayed(const Duration(milliseconds: 1000));
      final refreshedUser = await _authRepository.refreshJWT();
      if (refreshedUser != null) {
        emit(AuthStateAuthorized(user: user));
      } else {
        BotToast.showText(text: "Не удалось обновить токен");
        emit(const AuthStateUnauthorized());
      }
    } else {
      emit(const AuthStateUnauthorized());
    }
  }

  Future<void> _sendVerificationCode(AuthEventSendCode event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    await Future.delayed(const Duration(milliseconds: 1000));
    final code = await _authRepository.getVerificationCode(email: event.email);
    if (code != null) {
      emit(AuthStateCodeSent(email: event.email, code: code));
      // await _login(AuthEventLogin(email: event.email, code: code), emit);
    } else {
      BotToast.showText(text: "Не удалось отправить проверочный код");
    }
  }

  Future<void> _login(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    await Future.delayed(const Duration(milliseconds: 1000));
    final user = await _authRepository.login(email: event.email, code: event.code);
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
    await Future.delayed(const Duration(milliseconds: 1000));
    final user = await _authRepository.createUser(userInput: event.user);
    if (user != null) {
      emit(AuthStateAuthorized(user: user));
    } else {
      BotToast.showText(text: "Ошибка при создании пользователя");
    }
  }

  Future<void> _registerArtist(AuthEventRegisterArtist event, Emitter<AuthState> emit) async {
    emit(const AuthStatePending());
    await Future.delayed(const Duration(milliseconds: 1000));
    final user = await _authRepository.createUser(userInput: event.user);
    if (user != null) {
      final artistCreated = await _artistsRepository.createArtist(
        userInput: user,
        name: event.name,
        description: event.description,
        categoryId: event.categoryId,
        subcategoryIds: event.subcategoryIds,
      );
      if (artistCreated) emit(AuthStateAuthorized(user: event.user));
      if (!artistCreated) BotToast.showText(text: "Ошибка при создании артиста");
    }
  }

  Future<void> _logout(AuthEventLogout event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(const AuthStateGuest());
  }
}
