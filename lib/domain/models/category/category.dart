part of '../models.dart';

class CategoryModel {
  final int id;
  final String name;

  const CategoryModel({
    required this.id,
    required this.name,
  });

  static CategoryModel fromJson(dynamic source) {
    return CategoryModel(
      id: source['id'],
      name: source['name'],
    );
  }
}
