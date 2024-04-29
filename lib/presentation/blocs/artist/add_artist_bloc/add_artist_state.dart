part of 'add_artist_bloc.dart';

abstract class AddArtistState {
  const AddArtistState();
}

class AddArtistStateInitial extends AddArtistState {
  const AddArtistStateInitial();
}

class AddArtistStateLoading extends AddArtistState {
  const AddArtistStateLoading();
}

class AddArtistStateCreated extends AddArtistState {
  const AddArtistStateCreated();
}

class AddArtistStateFailed extends AddArtistState {
  const AddArtistStateFailed();
}
