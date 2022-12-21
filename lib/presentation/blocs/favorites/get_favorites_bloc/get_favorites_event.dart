part of 'get_favorites_bloc.dart';

abstract class GetFavoritesEvent extends Equatable {
  const GetFavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoritesEventGet extends GetFavoritesEvent {
  final bool needUpdate;

  const GetFavoritesEventGet({
    required this.needUpdate,
  });
}
