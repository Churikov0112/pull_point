import 'dart:math';
import 'dart:ui' show Color;

import 'package:flutter/material.dart' show Colors;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../domain/models/models.dart';

abstract class StaticMethods {
  static String durationInHoursAndMinutes(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)} ч $twoDigitMinutes мин";
  }

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

  static List<PullPointModel> filterPullPointsByNowPlaying({
    required List<PullPointModel> pullPoints,
  }) {
    final List<PullPointModel> filteredPullPoints = [];
    for (final pp in pullPoints) {
      if (pp.startsAt.isBefore(DateTime.now()) && pp.endsAt.isAfter(DateTime.now())) {
        filteredPullPoints.add(pp);
      }
    }
    return filteredPullPoints;
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

  static List<PullPointModel> filterPullPointsByCategoriesAndSubcategories({
    required List<PullPointModel> pullPoints,
    required CategoriesFilter? categoriesFilter,
  }) {
    if (categoriesFilter != null) {
      final List<PullPointModel> filteredPullPoints = [];
      for (final category in categoriesFilter.selectedCategories) {
        for (final pp in pullPoints) {
          if (pp.category == category) {
            filteredPullPoints.add(pp);
          }
        }
      }

      if (categoriesFilter.selectedSubcategories.isNotEmpty) {
        final List<PullPointModel> result = [];
        for (final subcategory in categoriesFilter.selectedSubcategories) {
          for (final pp in filteredPullPoints) {
            if (pp.subcategories.contains(subcategory) && !result.contains(pp)) {
              result.add(pp);
            }
          }
        }
        return result;
      }

      return filteredPullPoints;
    }
    return pullPoints;
  }

  static Future<LatLng?> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LatLng? latLng;

    try {
      locationData = await location.getLocation();
      latLng = LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      return null;
    }
    return latLng;
  }
}
