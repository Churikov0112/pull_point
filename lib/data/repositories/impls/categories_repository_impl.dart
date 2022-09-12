import 'dart:convert';
import '../../../domain/domain.dart';
import '../../http_requests/http_requests.dart';

class CategoriesRepositoryImpl extends CategoriesRepositoryInterface {
  List<CategoryModel> categories = [];

  @override
  Future<List<CategoryModel>> getCategories() async {
    if (categories.isEmpty) {
      categories.clear();
      final response = await GetCategoriesRequest.send();
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      for (final element in decodedResponse) {
        categories.add(CategoryModel.fromJson(element));
      }
    }

    return categories;
  }

  @override
  Future<List<SubcategoryModel>> getSubcategories({
    required List<int> parentCategoryIds,
  }) async {
    final List<SubcategoryModel> subcategories = [];
    for (final id in parentCategoryIds) {
      final response = await GetSubcategoriesRequest.send(categoryId: id);
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      for (final element in decodedResponse) {
        subcategories.add(SubcategoryModel.fromJson(element));
      }
    }
    return subcategories;
  }
}
