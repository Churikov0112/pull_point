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

class AuthStateEnterEmailPageOpened extends AuthState {
  final String? email;

  const AuthStateEnterEmailPageOpened({
    this.email,
  });
}

class AuthStateCodeSent extends AuthState {
  final String email;

  const AuthStateCodeSent({
    required this.email,
  });
}

class AuthStateCodeVerified extends AuthState {
  final UserModel user;

  const AuthStateCodeVerified({
    required this.user,
  });
}

class AuthStateArtistCreating extends AuthState {
  final UserModel user;
  const AuthStateArtistCreating({
    required this.user,
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
