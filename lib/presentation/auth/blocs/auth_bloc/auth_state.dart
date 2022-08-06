part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStatePending extends AuthState {
  const AuthStatePending();
}

class AuthStateUnauthorized extends AuthState {
  const AuthStateUnauthorized();
}

class AuthStateCodeSent extends AuthState {
  final String email;

  const AuthStateCodeSent({
    required this.email,
  });
}

class AuthStateCodeVerified extends AuthState {
  final int id;
  final String email;
  final String code;
  final String? username;

  const AuthStateCodeVerified({
    required this.id,
    required this.email,
    required this.code,
    required this.username,
  });
}

class AuthStateAuthorized extends AuthState {
  final UserModel user;

  const AuthStateAuthorized({
    required this.user,
  });
}

class AuthStateGuest extends AuthState {
  const AuthStateGuest();
}
