part of 'subcategories_bloc.dart';

abstract class SubcategoriesEvent {
  const SubcategoriesEvent();
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
