part of 'add_favorites_bloc.dart';

abstract class AddFavoritesEvent extends Equatable {
  const AddFavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddFavoritesEventAdd extends AddFavoritesEvent {
  final int artistId;

  const AddFavoritesEventAdd({
    required this.artistId,
  });
}
