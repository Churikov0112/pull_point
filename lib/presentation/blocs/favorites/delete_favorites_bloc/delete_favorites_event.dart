part of 'delete_favorites_bloc.dart';

abstract class DeleteFavoritesEvent {
  const DeleteFavoritesEvent();
}

class DeleteFavoritesEventDelete extends DeleteFavoritesEvent {
  final ArtistModel artist;

  const DeleteFavoritesEventDelete({
    required this.artist,
  });
}
