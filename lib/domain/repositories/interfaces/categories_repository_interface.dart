import '../../models/models.dart';

abstract class CategoriesRepositoryInterface {
  Future<List<CategoryModel>> getCategories();

  Future<List<SubcategoryModel>> getSubcategories({
    required List<int> parentCategoryIds,
  });
}
