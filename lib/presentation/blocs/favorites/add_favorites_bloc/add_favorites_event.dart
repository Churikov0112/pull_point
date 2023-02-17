part of 'add_favorites_bloc.dart';

abstract class AddFavoritesEvent extends Equatable {
  const AddFavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavoritesEventAdd extends AddFavoritesEvent {
  final ArtistModel artist;

  const AddFavoritesEventAdd({
    required this.artist,
  });
}
