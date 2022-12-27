part of 'delete_favorites_bloc.dart';

abstract class DeleteFavoritesState extends Equatable {
  const DeleteFavoritesState();

  @override
  List<Object> get props => [];
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
