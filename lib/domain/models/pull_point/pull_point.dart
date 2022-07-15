part of '../models.dart';

class PullPointModel {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime expireAt;
  final LatLng latLng;
  final ArtistModel artist;

  const PullPointModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.expireAt,
    required this.latLng,
    required this.artist,
  });
}
