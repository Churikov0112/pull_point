part of 'check_artist_name_existence_bloc.dart';

abstract class CheckArtistNameExistenceEvent {
  const CheckArtistNameExistenceEvent();
}

class CheckArtistNameExistenceEventCheck extends CheckArtistNameExistenceEvent {
  final String artistName;

  const CheckArtistNameExistenceEventCheck({
    required this.artistName,
  });
}

class CheckArtistNameExistenceEventReset extends CheckArtistNameExistenceEvent {
  const CheckArtistNameExistenceEventReset();
}
