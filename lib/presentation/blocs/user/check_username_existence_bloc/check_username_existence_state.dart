part of 'check_username_existence_bloc.dart';

abstract class CheckUsernameExistenceState {
  const CheckUsernameExistenceState();
}

class CheckUsernameExistenceStateInitial extends CheckUsernameExistenceState {
  const CheckUsernameExistenceStateInitial();
}

class CheckUsernameExistenceStatePending extends CheckUsernameExistenceState {
  const CheckUsernameExistenceStatePending();
}

class CheckUsernameExistenceStateExists extends CheckUsernameExistenceState {
  const CheckUsernameExistenceStateExists();
}

class CheckUsernameExistenceStateNotExists extends CheckUsernameExistenceState {
  const CheckUsernameExistenceStateNotExists();
}

class CheckUsernameExistenceStateFailed extends CheckUsernameExistenceState {
  final String? reason;
  const CheckUsernameExistenceStateFailed({
    required this.reason,
  });
}
