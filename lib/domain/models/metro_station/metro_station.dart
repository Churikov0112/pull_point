part of '../models.dart';

enum MetroLines { firstRed, secondBlue, thirdGreen, fourthOrange, fifthPurple }

class MetroStationModel {
  final int id;
  final String title;
  final LatLng latLng;
  final List<MetroLines> lines;

  const MetroStationModel({
    required this.id,
    required this.title,
    required this.latLng,
    required this.lines,
  });
}
