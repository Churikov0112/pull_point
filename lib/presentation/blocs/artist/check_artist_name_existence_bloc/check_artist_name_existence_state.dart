part of 'check_artist_name_existence_bloc.dart';

abstract class CheckArtistNameExistenceState {
  const CheckArtistNameExistenceState();
}

class CheckArtistNameExistenceStateInitial extends CheckArtistNameExistenceState {
  const CheckArtistNameExistenceStateInitial();
}

class CheckArtistNameExistenceStatePending extends CheckArtistNameExistenceState {
  const CheckArtistNameExistenceStatePending();
}

class CheckArtistNameExistenceStateExists extends CheckArtistNameExistenceState {
  const CheckArtistNameExistenceStateExists();
}

class CheckArtistNameExistenceStateNotExists extends CheckArtistNameExistenceState {
  const CheckArtistNameExistenceStateNotExists();
}

class CheckArtistNameExistenceStateFailed extends CheckArtistNameExistenceState {
  final String? message;
  const CheckArtistNameExistenceStateFailed({
    required this.message,
  });
}
