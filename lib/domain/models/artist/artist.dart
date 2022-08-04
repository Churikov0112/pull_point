part of '../models.dart';

class ArtistModel {
  final int id;
  final String name;
  final String description;
  final String? avatar;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.description,
    this.avatar,
  });

  static ArtistModel fromJson(dynamic source) {
    return ArtistModel(
      id: source['id'],
      name: source['name'],
      description: source['description'],
      avatar: source['avatar'],
    );
  }
}
