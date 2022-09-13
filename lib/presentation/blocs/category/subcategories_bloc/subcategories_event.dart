part of 'subcategories_bloc.dart';

abstract class SubcategoriesEvent extends Equatable {
  const SubcategoriesEvent();

  @override
  List<Object> get props => [];
}

class SubcategoriesEventLoad extends SubcategoriesEvent {
  final List<int> parentCategoryIds;

  const SubcategoriesEventLoad({
    required this.parentCategoryIds,
  });
}

class SubcategoriesEventReset extends SubcategoriesEvent {
  const SubcategoriesEventReset();
}
