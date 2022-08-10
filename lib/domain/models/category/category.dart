part of '../models.dart';

class CategoryModel {
  final int id;
  final String name;
  final List<SubcategoryModel> children;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.children,
  });
}
