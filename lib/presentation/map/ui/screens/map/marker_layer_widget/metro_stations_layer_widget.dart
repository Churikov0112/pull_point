import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pull_point/presentation/map/ui/screens/map/markers/metro_station/metro_station_marker.dart';

import '../../../../../../data/repositories/mock/metro_stations.dart';
import '../../../../../../domain/domain.dart';

class MetroStationsLayerWidget extends StatefulWidget {
  const MetroStationsLayerWidget({
    required this.mapController,
    Key? key,
  }) : super(key: key);

  final MapController mapController;

  @override
  State<MetroStationsLayerWidget> createState() => _MetroStationsLayerWidgetState();
}

class _MetroStationsLayerWidgetState extends State<MetroStationsLayerWidget> {
  LayerOptions metroMarkers(List<MetroStationModel> metroStations) {
    final List<Marker> metroStationsMarkers = [];
    for (final metro in metroStations) {
      metroStationsMarkers.add(
        Marker(
          height: 32,
          width: 32,
          point: metro.latLng,
          builder: (context) => MetroStationMarker(
            zoom: widget.mapController.zoom,
            metro: metro,
          ),
        ),
      );
    }
    return MarkerLayerOptions(markers: metroStationsMarkers, rotate: true);
  }

  @override
  Widget build(BuildContext context) {
    return GroupLayerWidget(
      options: GroupLayerOptions(
        group: [
          metroMarkers(MetroStations.getAllMetroStations()),
        ],
      ),
    );
  }
}
