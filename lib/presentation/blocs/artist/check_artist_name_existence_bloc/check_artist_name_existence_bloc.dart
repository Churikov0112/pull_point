import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'check_artist_name_existence_event.dart';
part 'check_artist_name_existence_state.dart';

class CheckArtistNameExistenceBloc extends Bloc<CheckArtistNameExistenceEvent, CheckArtistNameExistenceState> {
  CheckArtistNameExistenceBloc({
    required ArtistsRepositoryInterface artistsRepository,
  })  : _artistsRepository = artistsRepository,
        super(const CheckArtistNameExistenceStateInitial()) {
    on<CheckArtistNameExistenceEventCheck>(_checkArtistNameExistence);
    on<CheckArtistNameExistenceEventReset>(_reset);
  }

  final ArtistsRepositoryInterface _artistsRepository;

  Future<void> _checkArtistNameExistence(
      CheckArtistNameExistenceEventCheck event, Emitter<CheckArtistNameExistenceState> emit) async {
    emit(const CheckArtistNameExistenceStatePending());
    final exists = await _artistsRepository.checkArtistNameExistence(artistName: event.artistName);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (exists == null) {
      BotToast.showText(text: "Произошла ошибка при проверке имени артиста");
      emit(const CheckArtistNameExistenceStateInitial());
      return;
    }
    if (exists) {
      BotToast.showText(text: "Артист с таким именем уже существует");
      emit(const CheckArtistNameExistenceStateExists());
      return;
    } else {
      emit(const CheckArtistNameExistenceStateNotExists());
      return;
    }
  }

  Future<void> _reset(CheckArtistNameExistenceEventReset event, Emitter<CheckArtistNameExistenceState> emit) async {
    emit(const CheckArtistNameExistenceStateInitial());
  }
}
