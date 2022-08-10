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
}
