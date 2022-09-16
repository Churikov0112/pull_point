import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'delete_artist_event.dart';
part 'delete_artist_state.dart';

class DeleteArtistBloc extends Bloc<DeleteArtistEvent, DeleteArtistState> {
  final ArtistsRepositoryInterface _artistsRepository;

  DeleteArtistBloc({
    required ArtistsRepositoryInterface artistsRepository,
  })  : _artistsRepository = artistsRepository,
        super(const DeleteArtistStateInitial()) {
    on<DeleteArtistEventDelete>(_delete);
  }

  Future<void> _delete(DeleteArtistEventDelete event, Emitter<DeleteArtistState> emit) async {
    final created = await _artistsRepository.deleteArtist(
      artistId: event.artistId,
    );
    if (created) {
      emit(const DeleteArtistStateDeleted());
      BotToast.showText(text: "Артист успешно удален");
      emit(const DeleteArtistStateInitial());
    } else {
      BotToast.showText(text: "Не удалось удалить Артиста");
      emit(const DeleteArtistStateInitial());
    }
  }
}
