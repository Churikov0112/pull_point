part of 'delete_artist_bloc.dart';

abstract class DeleteArtistState {
  const DeleteArtistState();
}

class DeleteArtistStateInitial extends DeleteArtistState {
  const DeleteArtistStateInitial();
}

class DeleteArtistStateLoading extends DeleteArtistState {
  const DeleteArtistStateLoading();
}

class DeleteArtistStateDeleted extends DeleteArtistState {
  const DeleteArtistStateDeleted();
}
