import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepositoryInterface _categoriesRepository;

  CategoriesBloc({
    required CategoriesRepositoryInterface categoriesRepository,
  })  : _categoriesRepository = categoriesRepository,
        super(const CategoriesStateInitial()) {
    on<CategoriesEventLoad>(_load);
    on<CategoriesEventReset>(_reset);
  }

  Future<void> _load(CategoriesEventLoad event, Emitter<CategoriesState> emit) async {
    final categories = await _categoriesRepository.getCategories();
    emit(CategoriesStateLoaded(categories: categories));
  }

  Future<void> _reset(CategoriesEventReset event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesStateInitial());
  }
}
