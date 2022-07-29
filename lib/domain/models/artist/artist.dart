part of '../models.dart';

class ArtistModel {
  final int id;
  final String name;
  final String description;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.description,
  });

  static ArtistModel fromJson(dynamic source) {
    return ArtistModel(
      id: source['id'],
      name: source['name'],
      description: source['description'],
    );
  }
}
