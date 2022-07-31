part of '../models.dart';

class NearestMetroFilter extends AbstractFilter {
  final List<MetroStationModel> selectedMetroStations;

  NearestMetroFilter({
    required this.selectedMetroStations,
  }) : super(id: 1);
}
