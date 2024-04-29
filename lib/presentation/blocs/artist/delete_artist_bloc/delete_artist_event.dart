part of 'delete_artist_bloc.dart';

abstract class DeleteArtistEvent {
  const DeleteArtistEvent();
}

class DeleteArtistEventDelete extends DeleteArtistEvent {
  final int artistId;

  const DeleteArtistEventDelete({
    required this.artistId,
  });
}
