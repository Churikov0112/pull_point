part of 'check_username_existence_bloc.dart';

abstract class CheckUsernameExistenceEvent {
  const CheckUsernameExistenceEvent();
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
