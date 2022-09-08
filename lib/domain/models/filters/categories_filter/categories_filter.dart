part of '../../models.dart';

class CategoriesFilter extends AbstractFilter {
  final List<CategoryModel> selectedCategories;
  final List<SubcategoryModel> selectedSubcategories;

  CategoriesFilter({
    required this.selectedCategories,
    required this.selectedSubcategories,
  }) : super();
}
