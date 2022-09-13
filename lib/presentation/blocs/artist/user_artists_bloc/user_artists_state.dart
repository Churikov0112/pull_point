part of 'user_artists_bloc.dart';

abstract class UserArtistsState extends Equatable {
  const UserArtistsState();

  @override
  List<Object> get props => [];
}

class UserArtistsStateInitial extends UserArtistsState {
  const UserArtistsStateInitial();
}

class UserArtistsStateLoading extends UserArtistsState {
  const UserArtistsStateLoading();
}

class UserArtistsStateSelected extends UserArtistsState {
  final List<ArtistModel> allUserArtists;
  final ArtistModel selectedArtist;

  const UserArtistsStateSelected({
    required this.allUserArtists,
    required this.selectedArtist,
  });

  @override
  List<Object> get props => [selectedArtist, allUserArtists];
}
