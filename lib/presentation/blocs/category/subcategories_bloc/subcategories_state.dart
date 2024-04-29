part of 'subcategories_bloc.dart';

abstract class SubcategoriesState {
  const SubcategoriesState();
}

class SubcategoriesStateInitial extends SubcategoriesState {
  const SubcategoriesStateInitial();
}

class SubcategoriesStateLoading extends SubcategoriesState {
  const SubcategoriesStateLoading();
}

class SubcategoriesStateLoaded extends SubcategoriesState {
  final List<SubcategoryModel> subcategories;

  const SubcategoriesStateLoaded({
    required this.subcategories,
  });
}
