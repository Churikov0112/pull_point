import '../../../domain/models/models.dart';

abstract class Categories {
  // use as const
  static final List<CategoryModel> _allCategories = [
    const CategoryModel(
      id: 1,
      name: "Музыка",
      children: [
        SubcategoryModel(id: 11, parentId: 1, name: "Джаз"),
        SubcategoryModel(id: 12, parentId: 1, name: "Рок"),
        SubcategoryModel(id: 13, parentId: 1, name: "Рэп"),
        SubcategoryModel(id: 14, parentId: 1, name: "Кавер"),
        SubcategoryModel(id: 15, parentId: 1, name: "Регги"),
        SubcategoryModel(id: 16, parentId: 1, name: "Авторский контент"),
      ],
    ),
    const CategoryModel(id: 2, name: "Фаер-шоу", children: []),
    const CategoryModel(id: 3, name: "Фокусы", children: []),
    const CategoryModel(id: 4, name: "Саберфайтинг", children: []),
  ];

  static List<CategoryModel> getCategories() {
    return _allCategories;
  }

  static List<SubcategoryModel> getSubcategoriesOfCategory({
    required int categoryId,
  }) {
    final List<SubcategoryModel> result = [];
    for (final cat in _allCategories) {
      if (cat.id == categoryId) {
        result.addAll(cat.children);
      }
    }
    return result;
  }
}
