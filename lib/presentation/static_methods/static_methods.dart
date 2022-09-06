import 'dart:math';
import 'dart:ui' show Color;
import 'package:flutter/material.dart' show Colors;
import '../../domain/models/models.dart';

abstract class StaticMethods {
  static Color getColorByMetroLine(MetroLines line) {
    switch (line) {
      case MetroLines.firstRed:
        return Colors.red;
      case MetroLines.secondBlue:
        return Colors.blue;
      case MetroLines.thirdGreen:
        return Colors.green;
      case MetroLines.fourthOrange:
        return Colors.deepOrange;
      case MetroLines.fifthPurple:
        return Colors.deepPurple;
      default:
        return Colors.transparent;
    }
  }

  static double distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
    var earthRadiusKm = 6371;

    var dLat = (lat2 - lat1) * pi / 180;
    var dLon = (lon2 - lon1) * pi / 180;

    lat1 = (lat1) * pi / 180;
    lat2 = (lat2) * pi / 180;

    var a = sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  static bool isPullPointGoingNow(PullPointModel pullPoint) {
    if (pullPoint.startsAt.isBefore(DateTime.now()) && pullPoint.endsAt.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  static List<PullPointModel> filterPullPointsByDate({
    required List<PullPointModel> pullPoints,
    required DateFilter? dateFilter,
  }) {
    if (dateFilter != null) {
      final List<PullPointModel> filteredPullPoints = [];
      for (final pp in pullPoints) {
        if (pp.startsAt.isAfter(dateFilter.dateRange.start) && pp.endsAt.isBefore(dateFilter.dateRange.end)) {
          filteredPullPoints.add(pp);
        }
      }
      return filteredPullPoints;
    }
    return pullPoints;
  }

  static List<PullPointModel> filterPullPointsByTime({
    required List<PullPointModel> pullPoints,
    required TimeFilter? timeFilter,
  }) {
    if (timeFilter != null) {
      final List<PullPointModel> filteredPullPoints = [];
      for (final pp in pullPoints) {
        if (pp.startsAt.hour >= timeFilter.timeRange.start.hour) {
          if (pp.startsAt.minute >= timeFilter.timeRange.start.minute) {
            if (pp.endsAt.hour <= timeFilter.timeRange.end.hour) {
              if (pp.startsAt.minute <= timeFilter.timeRange.end.minute) {
                filteredPullPoints.add(pp);
              }
            }
          }
        }
      }
      return filteredPullPoints;
    }
    return pullPoints;
  }

  static List<PullPointModel> filterPullPointsByNearestMetro({
    required List<PullPointModel> pullPoints,
    required NearestMetroFilter? nearestMetroFilter,
  }) {
    if (nearestMetroFilter != null) {
      final List<PullPointModel> filteredPullPoints = [];
      for (final pp in pullPoints) {
        for (final metro in nearestMetroFilter.selectedMetroStations) {
          if (pp.nearestMetroStations.contains(metro) && !filteredPullPoints.contains(pp)) {
            filteredPullPoints.add(pp);
          }
        }
      }
      return filteredPullPoints;
    }
    return pullPoints;
  }
}
