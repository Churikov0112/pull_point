part of '../models.dart';

class PullPointModel {
  final int id;
  final String title;
  final String description;
  final String address;
  final LatLng latLng;
  final ArtistModel artist;
  final DateTime createdAt;
  final DateTime startsAt;
  final DateTime endsAt;

  final String? posterUrl;

  const PullPointModel({
    required this.id,
    required this.title,
    required this.address,
    required this.startsAt,
    required this.createdAt,
    required this.endsAt,
    required this.latLng,
    required this.artist,
    required this.description,
    this.posterUrl,
  });
}
