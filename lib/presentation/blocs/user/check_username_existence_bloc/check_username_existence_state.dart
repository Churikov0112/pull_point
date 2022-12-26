part of 'check_username_existence_bloc.dart';

abstract class CheckUsernameExistenceState extends Equatable {
  const CheckUsernameExistenceState();

  @override
  List<Object> get props => [];
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
