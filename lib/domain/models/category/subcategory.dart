part of '../models.dart';

class SubcategoryModel {
  final int id;
  final int parentId;
  final String name;

  const SubcategoryModel({
    required this.id,
    required this.parentId,
    required this.name,
  });

  static SubcategoryModel fromJson(dynamic source) {
    return SubcategoryModel(
      id: source['id'],
      name: source['name'],
      parentId: source['parent']['id'],
    );
  }
}
