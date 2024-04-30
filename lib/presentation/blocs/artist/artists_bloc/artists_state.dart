part of 'artists_bloc.dart';

abstract class ArtistsState {
  const ArtistsState();
}

class ArtistsStateInitial extends ArtistsState {
  const ArtistsStateInitial();
}

class ArtistsStateLoading extends ArtistsState {
  const ArtistsStateLoading();
}

class ArtistsStateLoaded extends ArtistsState {
  final List<ArtistModel> artists;

  const ArtistsStateLoaded({
    required this.artists,
  });
}

class ArtistsStateFailed extends ArtistsState {
  final String? message;
  const ArtistsStateFailed({
    required this.message,
  });
}
