import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/domain.dart';
import '../../config/config.dart';

class CategoriesRepositoryImpl extends CategoriesRepositoryInterface {
  List<CategoryModel> categories = [];

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      if (categories.isEmpty) {
        categories.clear();
        final response = await http.get(Uri.parse("${BackendConfig.baseUrl}/category/main"));
        String source = const Utf8Decoder().convert(response.bodyBytes);
        print(source);

        final decodedResponse = jsonDecode(source);
        for (final element in decodedResponse) {
          categories.add(CategoryModel.fromJson(element));
        }
      }
    } catch (e) {
      print(e);
    }
    return categories;
  }

  @override
  Future<List<SubcategoryModel>> getSubcategories({
    required int parentCategoryId,
  }) async {
    final List<SubcategoryModel> subcategories = [];
    try {
      final response = await http.get(Uri.parse("${BackendConfig.baseUrl}/category/$parentCategoryId"));
      String source = const Utf8Decoder().convert(response.bodyBytes);
      print(source);

      final decodedResponse = jsonDecode(source);
      for (final element in decodedResponse) {
        subcategories.add(SubcategoryModel.fromJson(element));
      }
    } catch (e) {
      print(e);
    }
    return subcategories;
  }
}
