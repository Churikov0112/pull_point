import 'package:flutter/material.dart' show CircularProgressIndicator, Colors, FloatingActionButton, Icons, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../blocs/blocs.dart';
import '../../../../static_methods/static_methods.dart';
import '../map/marker_layer_widget/metro_stations_layer_widget.dart';
import '../map/marker_layer_widget/pull_points_layer_widget.dart';
import '../pull_point_bottom_sheet/pull_point_bottom_sheet.dart';

final _kDefaultLatLng = LatLng(59.9386, 30.3141);
const _kDefaultZoom = 10.0;
const _kMinZoom = 4.0;
const _kMaxZoom = 18.0;

final kTileLayerOptions = TileLayerOptions(
  backgroundColor: Colors.white,
  urlTemplate: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
  subdomains: ['a', 'b', 'c'],
  // free maps
  // https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png
  // https://tile.openstreetmap.org/{z}/{x}/{y}.png
);

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({
    required this.onSubmit,
    this.initialCenter,
    Key? key,
  }) : super(key: key);

  final Function(LatLng? location) onSubmit;
  final LatLng? initialCenter;

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late final MapController mapController;
  LatLng? _currentUserLocation;
  bool loadingLocation = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  Future<LatLng?> getLocation() async {
    setState(() => loadingLocation = true);
    LatLng? userLocation;
    userLocation = await StaticMethods.getUserLocation();
    if (userLocation != null) {
      setState(() => _currentUserLocation = userLocation);
    } else {
      setState(() => loadingLocation = false);
    }
    setState(() => loadingLocation = false);
    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // map & points
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              maxZoom: _kMaxZoom,
              minZoom: _kMinZoom,
              zoom: _kDefaultZoom,
              center: widget.initialCenter ?? _kDefaultLatLng,
            ),
            children: [
              TileLayerWidget(options: kTileLayerOptions),
              MetroStationsLayerWidget(mapController: mapController),
              PullPointsLayerWidget(mapController: mapController),
              if (_currentUserLocation != null)
                MarkerLayerWidget(
                  options: MarkerLayerOptions(
                    markers: [
                      Marker(
                        point: LatLng(_currentUserLocation!.latitude, _currentUserLocation!.longitude),
                        builder: (context) => Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                          child: const Center(
                            child: Text(
                              "me",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // find location button
          Positioned(
            right: 16,
            bottom: 80,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              onPressed: () async {
                if (_currentUserLocation == null) {
                  final newLocation = await getLocation();
                  if (newLocation != null) {
                    mapController.move(newLocation, _kDefaultZoom);
                  }
                } else {
                  setState(() => _currentUserLocation = null);
                  mapController.move(_kDefaultLatLng, _kDefaultZoom);
                }
              },
              child: Center(
                child: loadingLocation
                    ? const CircularProgressIndicator()
                    : _currentUserLocation != null
                        ? const Icon(Icons.place, color: Colors.orange)
                        : const Icon(Icons.place_outlined, color: Colors.grey),
              ),
            ),
          ),

          // confirm button
          Positioned(
            right: 16,
            bottom: 15,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.purple,
              onPressed: () {
                widget.onSubmit(mapController.center);
                Navigator.of(context).pop();
              },
              child: const Center(child: Icon(Icons.check)),
            ),
          ),

          const Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Icon(
              Icons.place,
              size: 50,
              color: Colors.purple,
            ),
          ),

          // pp bs
          BlocBuilder<PullPointsBloc, PullPointsState>(builder: (context, state) {
            if (state is PullPointsStateSelected) {
              return PullPointBottomSheet(
                pullPoint: state.selectedPullPoint,
                onClose: () {
                  // mapController.move(_kDefaultLatLng, _kDefaultZoom);
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
