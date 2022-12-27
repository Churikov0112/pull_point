import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'delete_favorites_event.dart';
part 'delete_favorites_state.dart';

class DeleteFavoritesBloc extends Bloc<DeleteFavoritesEvent, DeleteFavoritesState> {
  DeleteFavoritesBloc({
    required FavoritesRepositoryInterface favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(const DeleteFavoritesStateInitial()) {
    on<DeleteFavoritesEventDelete>(_deleteArtistFromFavorites);
  }

  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _deleteArtistFromFavorites(DeleteFavoritesEventDelete event, Emitter<DeleteFavoritesState> emit) async {
    emit(DeleteFavoritesStatePending(artistId: event.artistId));
    final succeeded = await _favoritesRepository.deleteArtistFromUserFavorites(artistId: event.artistId);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (succeeded) {
      emit(const DeleteFavoritesStateReady());
      BotToast.showText(text: "Артист успешно удален из избранного");
      return;
    } else {
      emit(const DeleteFavoritesStateFailed(reason: "Произошла ошибка при удалении артиста из избранного"));
      BotToast.showText(text: "Произошла ошибка при удалении артиста из избранного");
      return;
    }
  }
}
