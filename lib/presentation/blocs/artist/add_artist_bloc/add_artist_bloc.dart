import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'add_artist_event.dart';
part 'add_artist_state.dart';

class AddArtistBloc extends Bloc<AddArtistEvent, AddArtistState> {
  final ArtistsRepositoryInterface _artistsRepository;

  AddArtistBloc({
    required ArtistsRepositoryInterface artistsRepository,
  })  : _artistsRepository = artistsRepository,
        super(const AddArtistStateInitial()) {
    on<AddArtistEventCreate>(_create);
  }

  Future<void> _create(AddArtistEventCreate event, Emitter<AddArtistState> emit) async {
    final created = await _artistsRepository.createArtist(
      userInput: event.userInput,
      name: event.name,
      description: event.description,
      categoryId: event.categoryId,
      subcategoryIds: event.subcategoryIds,
    );
    if (created) {
      emit(const AddArtistStateCreated());
      BotToast.showText(text: "Артист успешно создан");
      emit(const AddArtistStateInitial());
    } else {
      BotToast.showText(text: "Не удалось создать Артиста");
      emit(const AddArtistStateInitial());
    }
  }
}
