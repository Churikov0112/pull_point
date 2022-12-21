part of 'add_favorites_bloc.dart';

abstract class AddFavoritesState extends Equatable {
  const AddFavoritesState();

  @override
  List<Object> get props => [];
}

class AddFavoritesStateInitial extends AddFavoritesState {
  const AddFavoritesStateInitial();
}

class AddFavoritesStatePending extends AddFavoritesState {
  const AddFavoritesStatePending();
}

class AddFavoritesStateReady extends AddFavoritesState {
  const AddFavoritesStateReady();
}

class AddFavoritesStateFailed extends AddFavoritesState {
  final String reason;

  const AddFavoritesStateFailed({
    required this.reason,
  });
}
