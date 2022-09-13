part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// проходите на главную сраницу неавторизованным
class AuthEventContinueAsGuest extends AuthEvent {
  const AuthEventContinueAsGuest();
}

// проверка наличия юзера локально
class AuthEventCheckAccoutLocally extends AuthEvent {
  const AuthEventCheckAccoutLocally();
}

// открыть WannaBeArtistPage
class AuthEventOpenWannaBeArtistPage extends AuthEvent {
  final UserModel user;

  const AuthEventOpenWannaBeArtistPage({
    required this.user,
  });
}

// открыть EnterArtistDataPage
class AuthEventOpenUpdateArtistPage extends AuthEvent {
  final UserModel user;

  const AuthEventOpenUpdateArtistPage({
    required this.user,
  });
}

// открыть EnterEmailPage
class AuthEventOpenEmailPage extends AuthEvent {
  final String? email;

  const AuthEventOpenEmailPage({
    this.email,
  });
}

// отправить код подтверждения на почту
class AuthEventSendCode extends AuthEvent {
  final String email;

  const AuthEventSendCode({
    required this.email,
  });
}

// проверить введенный юзером код на верность
class AuthEventLogin extends AuthEvent {
  final String email;
  final String code;

  const AuthEventLogin({
    required this.email,
    required this.code,
  });
}

// создание нового пользователя (если он НЕ хочет быть артистом)
class AuthEventRegisterUser extends AuthEvent {
  final UserModel user;

  const AuthEventRegisterUser({
    required this.user,
  });
}

// создание нового артиста
class AuthEventRegisterArtist extends AuthEvent {
  final UserModel user;
  final String name;
  final String description;
  final int categoryId;
  final List<int> subcategoryIds;

  const AuthEventRegisterArtist({
    required this.user,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.subcategoryIds,
  });
}

// выход из аккаунта, удаление данных из локальной БД
class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}
