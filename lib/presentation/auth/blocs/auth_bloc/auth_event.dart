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

class AuthEventOpenEmailPage extends AuthEvent {
  final String? email;

  const AuthEventOpenEmailPage({
    this.email,
  });
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

class AuthEventRegisterUser extends AuthEvent {
  final int id;
  final String email;
  final String username;
  final bool wannaBeArtist;

  const AuthEventRegisterUser({
    required this.id,
    required this.email,
    required this.username,
    required this.wannaBeArtist,
  });
}

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

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}
