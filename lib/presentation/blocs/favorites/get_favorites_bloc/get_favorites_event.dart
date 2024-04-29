part of 'get_favorites_bloc.dart';

abstract class GetFavoritesEvent {
  const GetFavoritesEvent();
}

class GetFavoritesEventGet extends GetFavoritesEvent {
  final bool needUpdate;

  const GetFavoritesEventGet({
    required this.needUpdate,
  });
}
