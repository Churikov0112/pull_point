part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [categories];
}
