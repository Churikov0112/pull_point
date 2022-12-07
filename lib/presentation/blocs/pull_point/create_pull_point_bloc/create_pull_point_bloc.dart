import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'create_pull_point_event.dart';
part 'create_pull_point_state.dart';

class CreatePullPointBloc extends Bloc<CreatePullPointEvent, CreatePullPointState> {
  final PullPointsRepositoryInterface _pullPointsRepository;

  CreatePullPointBloc({
    required PullPointsRepositoryInterface pullPointsRepository,
  })  : _pullPointsRepository = pullPointsRepository,
        super(const CreatePullPointStateInitial()) {
    on<CreatePullPointEventCreate>(_create);
    on<CreatePullPointEventReset>(_reset);
  }

  Future<void> _create(CreatePullPointEventCreate event, Emitter<CreatePullPointState> emit) async {
    final created = await _pullPointsRepository.createPullPoint(
      name: event.name,
      description: event.description,
      ownerId: event.ownerId,
      latitude: event.latitude,
      longitude: event.longitude,
      startTime: event.startTime,
      endTime: event.endTime,
      categoryId: event.categoryId,
      subcategoryIds: event.subcategoryIds,
    );
    if (created) {
      emit(const CreatePullPointStateCreated());
      BotToast.showText(text: "Pull Point успешно создан");
    } else {
      BotToast.showText(text: "Не удалось создать Pull Point");
      emit(const CreatePullPointStateInitial());
    }
  }

  void _reset(CreatePullPointEventReset event, Emitter<CreatePullPointState> emit) async {
    emit(const CreatePullPointStateInitial());
  }
}
