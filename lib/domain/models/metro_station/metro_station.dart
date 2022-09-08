part of '../models.dart';

enum MetroLines { firstRed, secondBlue, thirdGreen, fourthOrange, fifthPurple }

class MetroStationModel extends Equatable {
  final int id;
  final String title;
  final LatLng latLng;
  final MetroLines line;

  const MetroStationModel({
    required this.id,
    required this.title,
    required this.latLng,
    required this.line,
  });

  @override
  List<Object?> get props => [id];
}
