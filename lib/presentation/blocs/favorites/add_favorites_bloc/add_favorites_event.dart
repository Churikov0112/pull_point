part of 'add_favorites_bloc.dart';

abstract class AddFavoritesEvent {
  const AddFavoritesEvent();
}

class AddFavoritesEventAdd extends AddFavoritesEvent {
  final ArtistModel artist;

  const AddFavoritesEventAdd({
    required this.artist,
  });
}
