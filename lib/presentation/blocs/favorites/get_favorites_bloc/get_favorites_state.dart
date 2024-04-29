part of 'get_favorites_bloc.dart';

abstract class GetFavoritesState {
  const GetFavoritesState();
}

class GetFavoritesStateInitial extends GetFavoritesState {
  const GetFavoritesStateInitial();
}

class GetFavoritesStatePending extends GetFavoritesState {
  const GetFavoritesStatePending();
}

class GetFavoritesStateLoaded extends GetFavoritesState {
  final List<ArtistModel> favorites;

  const GetFavoritesStateLoaded({
    required this.favorites,
  });
}

class GetFavoritesStateFailed extends GetFavoritesState {
  final String reason;

  const GetFavoritesStateFailed({
    required this.reason,
  });
}
