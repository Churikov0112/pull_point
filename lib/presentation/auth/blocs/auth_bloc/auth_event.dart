part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventContinueAsGuest extends AuthEvent {
  const AuthEventContinueAsGuest();
}

class AuthEventCheckAccoutLocally extends AuthEvent {
  const AuthEventCheckAccoutLocally();
}

class AuthEventSendCode extends AuthEvent {
  final String email;

  const AuthEventSendCode({
    required this.email,
  });
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String code;

  const AuthEventLogin({
    required this.email,
    required this.code,
  });
}

class AuthEventRegister extends AuthEvent {
  final int id;
  final String email;
  final String username;

  const AuthEventRegister({
    required this.id,
    required this.email,
    required this.username,
  });
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}
