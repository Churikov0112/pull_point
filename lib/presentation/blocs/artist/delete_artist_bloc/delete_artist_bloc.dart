// import 'package:bot_toast/bot_toast.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../domain/domain.dart';

// part 'delete_artist_event.dart';
// part 'delete_artist_state.dart';

// class DeleteArtistBloc extends Bloc<DeleteArtistEvent, DeleteArtistState> {
//   final ArtistsRepositoryInterface _artistsRepository;

//   DeleteArtistBloc({
//     required ArtistsRepositoryInterface artistsRepository,
//   })  : _artistsRepository = artistsRepository,
//         super(const DeleteArtistStateInitial()) {
//     on<DeleteArtistEventCreate>(_create);
//   }

//   Future<void> _create(DeleteArtistEventCreate event, Emitter<DeleteArtistState> emit) async {
//     final created = await _artistsRepository.createArtist(
//       userInput: event.userInput,
//       name: event.name,
//       description: event.description,
//       categoryId: event.categoryId,
//       subcategoryIds: event.subcategoryIds,
//     );
//     if (created) {
//       emit(const DeleteArtistStateCreated());
//       BotToast.showText(text: "Артист успешно удален");
//     } else {
//       BotToast.showText(text: "Не удалось удалить Артиста");
//       emit(const DeleteArtistStateInitial());
//     }
//   }
// }
