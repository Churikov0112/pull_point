part of 'subcategories_bloc.dart';

abstract class SubcategoriesState extends Equatable {
  const SubcategoriesState();

  @override
  List<Object> get props => [];
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

  @override
  List<Object> get props => [subcategories];
}
