part of '../models.dart';

class SubcategoryModel extends Equatable {
  final int id;
  final String name;

  const SubcategoryModel({
    required this.id,
    required this.name,
  });

  static SubcategoryModel fromJson(dynamic source) {
    return SubcategoryModel(
      id: source['id'],
      name: source['name'],
    );
  }

  @override
  List<Object?> get props => [id];
}
