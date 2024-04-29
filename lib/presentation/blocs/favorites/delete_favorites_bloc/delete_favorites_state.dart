part of 'delete_favorites_bloc.dart';

abstract class DeleteFavoritesState {
  const DeleteFavoritesState();
}

class DeleteFavoritesStateInitial extends DeleteFavoritesState {
  const DeleteFavoritesStateInitial();
}

class DeleteFavoritesStatePending extends DeleteFavoritesState {
  final int artistId;

  const DeleteFavoritesStatePending({
    required this.artistId,
  });
}

class DeleteFavoritesStateReady extends DeleteFavoritesState {
  const DeleteFavoritesStateReady();
}

class DeleteFavoritesStateFailed extends DeleteFavoritesState {
  final String reason;

  const DeleteFavoritesStateFailed({
    required this.reason,
  });
}
