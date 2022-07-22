part of '../models.dart';

class CategoryModel {
  final int id;
  final String name;
  final List<CategoryModel>? children;
  final int? parentId;

  const CategoryModel({
    required this.id,
    required this.name,
    this.children,
    this.parentId,
  });
}
