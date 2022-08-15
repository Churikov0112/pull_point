part of '../models.dart';

class ArtistModel {
  final int id;
  final String name;
  final String description;
  final CategoryModel category;
  final List<SubcategoryModel> subcategories;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.subcategories,
  });

  static ArtistModel fromJson(dynamic source) {
    return ArtistModel(
      id: source['id'],
      name: source['name'],
      description: source['description'],
      category: CategoryModel.fromJson(source['category']),
      subcategories: [
        for (final subcat in source['subcategories']) SubcategoryModel.fromJson(subcat),
      ],
    );
  }
}
