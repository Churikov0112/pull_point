part of 'delete_favorites_bloc.dart';

abstract class DeleteFavoritesEvent extends Equatable {
  const DeleteFavoritesEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavoritesEventDelete extends DeleteFavoritesEvent {
  final int artistId;

  const DeleteFavoritesEventDelete({
    required this.artistId,
  });
}
