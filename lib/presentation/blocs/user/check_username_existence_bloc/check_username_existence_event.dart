part of 'check_username_existence_bloc.dart';

abstract class CheckUsernameExistenceEvent extends Equatable {
  const CheckUsernameExistenceEvent();

  @override
  List<Object> get props => [];
}

class CheckUsernameExistenceEventCheck extends CheckUsernameExistenceEvent {
  final String username;

  const CheckUsernameExistenceEventCheck({
    required this.username,
  });
}

class CheckUsernameExistenceEventReset extends CheckUsernameExistenceEvent {
  const CheckUsernameExistenceEventReset();
}
