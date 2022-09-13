part of 'artists_bloc.dart';

abstract class ArtistsState extends Equatable {
  const ArtistsState();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [artists];
}
