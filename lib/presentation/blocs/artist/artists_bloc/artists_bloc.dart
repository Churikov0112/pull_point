import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../domain/domain.dart';

part 'artists_event.dart';
part 'artists_state.dart';

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  final ArtistsRepositoryInterface _artistsRepository;

  ArtistsBloc({
    required ArtistsRepositoryInterface artistsRepository,
  })  : _artistsRepository = artistsRepository,
        super(const ArtistsStateInitial()) {
    on<ArtistsEventLoad>(_load);
  }

  Future<void> _load(ArtistsEventLoad event, Emitter<ArtistsState> emit) async {
    emit(const ArtistsStateLoading());
    final artists = await _artistsRepository.getArtists(
      search: event.search,
      categoryId: event.categoryId,
      subcategoryIds: event.subcategoryIds,
    );
    if (artists.isNotEmpty) {
      emit(ArtistsStateLoaded(artists: artists));
    } else {
      BotToast.showText(text: "Мы не смогли найти ни одного артиста о вашему запросу");
    }
  }
}
