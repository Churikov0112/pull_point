part of '../models.dart';

class ArtistModel extends Equatable {
  final int id;
  final String? name;
  final String? description;
  final CategoryModel? category;
  final List<SubcategoryModel>? subcategories;

  const ArtistModel({
    required this.id,
    this.name,
    this.description,
    this.category,
    this.subcategories,
  });

  static ArtistModel fromJson(dynamic source) {
    return ArtistModel(
      id: source['id'],
      name: source['name'],
      description: source['description'],
      category: source['category'] != null ? CategoryModel.fromJson(source['category']) : null,
      subcategories: [
        for (final subcat in source['subcategories']) SubcategoryModel.fromJson(subcat),
      ],
    );
  }

  @override
  List<Object?> get props => [id];
}
