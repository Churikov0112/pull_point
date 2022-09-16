part of 'delete_artist_bloc.dart';

abstract class DeleteArtistEvent extends Equatable {
  const DeleteArtistEvent();

  @override
  List<Object> get props => [];
}

class DeleteArtistEventDelete extends DeleteArtistEvent {
  final int artistId;

  const DeleteArtistEventDelete({
    required this.artistId,
  });

  @override
  List<Object> get props => [artistId];
}
