part of 'check_artist_name_existence_bloc.dart';

abstract class CheckArtistNameExistenceState extends Equatable {
  const CheckArtistNameExistenceState();

  @override
  List<Object> get props => [];
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
