import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'add_favorites_event.dart';
part 'add_favorites_state.dart';

class AddFavoritesBloc extends Bloc<AddFavoritesEvent, AddFavoritesState> {
  AddFavoritesBloc({
    required FavoritesRepositoryInterface favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(const AddFavoritesStateInitial()) {
    on<AddFavoritesEventAdd>(_addFavorites);
  }

  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _addFavorites(AddFavoritesEventAdd event, Emitter<AddFavoritesState> emit) async {
    emit(const AddFavoritesStatePending());
    final succeeded = await _favoritesRepository.addArtistToUserFavorites(artistId: event.artistId);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (succeeded) {
      emit(const AddFavoritesStateReady());
      BotToast.showText(text: "Артист успешно добавлен в избранное");
      return;
    } else {
      emit(const AddFavoritesStateFailed(reason: "Произошла ошибка при добавлении в избранное"));
      BotToast.showText(text: "Произошла ошибка при добавлении в избранное");
      return;
    }
  }
}
