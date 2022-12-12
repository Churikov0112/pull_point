import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../domain/domain.dart';

part 'user_artists_event.dart';
part 'user_artists_state.dart';

class UserArtistsBloc extends Bloc<UserArtistsEvent, UserArtistsState> {
  final ArtistsRepositoryInterface _artistsRepository;

  UserArtistsBloc({
    required ArtistsRepositoryInterface artistsRepository,
  })  : _artistsRepository = artistsRepository,
        super(const UserArtistsStateInitial()) {
    on<UserArtistsEventLoad>(_load);
    on<UserArtistsEventSelect>(_select);
    on<UserArtistsEventResetSelectOnLogout>(_reset);
  }

  Future<void> _load(UserArtistsEventLoad event, Emitter<UserArtistsState> emit) async {
    emit(const UserArtistsStateLoading());
    await Future.delayed(const Duration(seconds: 1));
    final artists = await _artistsRepository.getUserArtists(userId: event.userId);
    final selectedArtist = _artistsRepository.getSelectedArtist();
    if (selectedArtist != null) {
      emit(UserArtistsStateSelected(allUserArtists: artists, selectedArtist: selectedArtist));
    } else {
      BotToast.showText(text: "Вы можете выбрать артиста в вашем профиле");
    }
  }

  Future<void> _select(UserArtistsEventSelect event, Emitter<UserArtistsState> emit) async {
    final artists = await _artistsRepository.getUserArtists(userId: event.userId);
    _artistsRepository.selectArtist(artistId: event.artistId);
    final selectedArtist = _artistsRepository.getSelectedArtist();
    if (selectedArtist != null) {
      emit(UserArtistsStateSelected(allUserArtists: artists, selectedArtist: selectedArtist));
    } else {
      BotToast.showText(text: "Произошла ошибка при выборе артиста");
    }
  }

  Future<void> _reset(UserArtistsEventResetSelectOnLogout event, Emitter<UserArtistsState> emit) async {
    _artistsRepository.unselectArtistOnLogout();
  }
}
