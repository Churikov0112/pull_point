part of 'add_artist_bloc.dart';

abstract class AddArtistState extends Equatable {
  const AddArtistState();

  @override
  List<Object> get props => [];
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
