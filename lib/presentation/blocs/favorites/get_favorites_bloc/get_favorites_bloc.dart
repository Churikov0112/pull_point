import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  GetFavoritesBloc({
    required FavoritesRepositoryInterface favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(const GetFavoritesStateInitial()) {
    on<GetFavoritesEventGet>(_getFavorites);
  }

  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _getFavorites(GetFavoritesEventGet event, Emitter<GetFavoritesState> emit) async {
    emit(const GetFavoritesStatePending());
    final favorites = await _favoritesRepository.getUserFavorites();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (favorites != null) {
      emit(GetFavoritesStateLoaded(favorites: favorites));
      return;
    } else {
      emit(const GetFavoritesStateFailed(reason: "Произошла ошибка при получении списка избранных артистов"));
      return;
    }
  }
}
