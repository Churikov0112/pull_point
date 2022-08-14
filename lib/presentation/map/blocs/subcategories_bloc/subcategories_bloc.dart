import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

part 'subcategories_event.dart';
part 'subcategories_state.dart';

class SubcategoriesBloc extends Bloc<SubcategoriesEvent, SubcategoriesState> {
  final CategoriesRepositoryInterface _categoriesRepository;

  SubcategoriesBloc({
    required CategoriesRepositoryInterface categoriesRepository,
  })  : _categoriesRepository = categoriesRepository,
        super(const SubcategoriesStateInitial()) {
    on<SubcategoriesEventLoad>(_load);
  }

  Future<void> _load(SubcategoriesEventLoad event, Emitter<SubcategoriesState> emit) async {
    final subcategories = await _categoriesRepository.getSubcategories(parentCategoryId: event.parentCategoryId);
    emit(SubcategoriesStateLoaded(subcategories: subcategories));
  }
}
