import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final _kMapOptions = MapOptions(
  maxZoom: 18,
  minZoom: 4,
  zoom: 10,
  center: LatLng(59.9386, 30.3141),
);

final _kTileLayerOptions = TileLayerOptions(
  backgroundColor: Colors.white,
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  subdomains: ['a', 'b', 'c'],
);

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: MapController(),
      options: _kMapOptions,
      children: [
        TileLayerWidget(options: _kTileLayerOptions),
      ],
    );
  }
}

// https://www.openstreetmap.org/#map=6/51.944/25.917
