part of '../models.dart';

class PullPointModel {
  final int id;
  final String title;
  final String description;
  final Geo geo;
  final List<ArtistModel> artists;
  final DateTime startsAt;
  final DateTime endsAt;
  final String? posterUrl;
  final List<MetroStationModel> nearestMetroStations;

  const PullPointModel({
    required this.id,
    required this.title,
    required this.geo,
    required this.startsAt,
    required this.endsAt,
    required this.artists,
    required this.description,
    required this.nearestMetroStations,
    this.posterUrl,
  });

  static PullPointModel fromJson(dynamic source) {
    return PullPointModel(
      id: source['id'],
      title: source['name'],
      description: source['description'],
      geo: Geo.fromJson(source['geo']),
      startsAt: DateTime.fromMillisecondsSinceEpoch(source['start'] * 1000),
      endsAt: DateTime.fromMillisecondsSinceEpoch(source['end'] * 1000),
      artists: [
        for (final artist in source['artists']) ArtistModel.fromJson(artist),
      ],
      posterUrl: source['posterUrl'],
      nearestMetroStations: MetroStations.getNearestMetroStations(latLng: Geo.fromJson(source['geo']).latLng),
    );
  }
}
