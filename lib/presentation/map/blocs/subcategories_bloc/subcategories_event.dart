part of 'subcategories_bloc.dart';

abstract class SubcategoriesEvent extends Equatable {
  const SubcategoriesEvent();

  @override
  List<Object> get props => [];
}

class SubcategoriesEventLoad extends SubcategoriesEvent {
  final int parentCategoryId;

  const SubcategoriesEventLoad({
    required this.parentCategoryId,
  });
}
