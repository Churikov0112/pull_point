part of '../models.dart';

class PullPointModel {
  final int id;
  final String title;
  final String description;
  final CategoryModel category;
  final List<SubcategoryModel> subcategories;
  final Geo geo;
  final ArtistModel owner;
  final List<ArtistModel> artists;
  final DateTime startsAt;
  final DateTime endsAt;
  final String? posterUrl;
  final List<MetroStationModel> nearestMetroStations;

  const PullPointModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.subcategories,
    required this.geo,
    required this.startsAt,
    required this.endsAt,
    required this.owner,
    required this.artists,
    required this.nearestMetroStations,
    this.posterUrl,
  });

  static PullPointModel fromJson(dynamic source) {
    return PullPointModel(
      id: source['id'],
      title: source['name'],
      description: source['description'],
      geo: Geo(latLng: LatLng(source['latitude'], source['longitude'])),
      startsAt: DateTime.parse(source['startTime']),
      endsAt: DateTime.parse(source['endTime']),
      owner: ArtistModel.fromJson(source['owner']),
      artists: [
        for (final artist in source['artists']) ArtistModel.fromJson(artist),
      ],
      category: CategoryModel.fromJson(source['category']),
      subcategories: [
        for (final subcat in source['subcategories']) SubcategoryModel.fromJson(subcat),
      ],
      // posterUrl: source['posterUrl'],
      nearestMetroStations:
          MetroStations.getNearestMetroStations(latLng: LatLng(source['latitude'], source['longitude'])),
    );
  }
}
