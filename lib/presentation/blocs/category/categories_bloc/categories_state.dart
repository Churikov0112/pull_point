part of 'categories_bloc.dart';

abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesStateInitial extends CategoriesState {
  const CategoriesStateInitial();
}

class CategoriesStateLoading extends CategoriesState {
  const CategoriesStateLoading();
}

class CategoriesStateLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesStateLoaded({
    required this.categories,
  });
}
