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
    } else {
      emit(const CreatePullPointStateFailed());
      emit(const CreatePullPointStateInitial());
    }
  }
}