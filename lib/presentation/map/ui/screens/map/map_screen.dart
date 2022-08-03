import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show CircularProgressIndicator, Colors, FloatingActionButton, Icons, MaterialPageRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pull_point/presentation/map/ui/screens/create_pp_screen.dart';

import '../../../blocs/blocs.dart';
import 'marker_layer_widget/pull_point_bottom_sheet/pull_point_bottom_sheet.dart';
import 'marker_layer_widget/pull_points_layer_widget.dart';

final _kDefaultLatLng = LatLng(59.9386, 30.3141);
const _kDefaultZoom = 10.0;
const _kMinZoom = 4.0;
const _kMaxZoom = 18.0;

final _kMapOptions = MapOptions(
  maxZoom: _kMaxZoom,
  minZoom: _kMinZoom,
  zoom: _kDefaultZoom,
  center: _kDefaultLatLng,
);

final _kTileLayerOptions = TileLayerOptions(
  backgroundColor: Colors.white,
  urlTemplate: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
  subdomains: ['a', 'b', 'c'],
  // free maps
  // https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png
  // https://tile.openstreetmap.org/{z}/{x}/{y}.png
);

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController mapController;
  Position? _currentPosition;
  bool loadingLocation = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void getLocation() async {
    setState(() => loadingLocation = true);

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      setState(() => loadingLocation = false);
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => loadingLocation = false);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => loadingLocation = false);
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (_currentPosition != null) {
      mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 16);
    }

    setState(() => loadingLocation = false);
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        // map & points
        FlutterMap(
          mapController: mapController,
          options: _kMapOptions,
          children: [
            TileLayerWidget(options: _kTileLayerOptions),
            PullPointsLayerWidget(mapController: mapController),
            if (_currentPosition != null)
              MarkerLayerWidget(
                options: MarkerLayerOptions(
                  markers: [
                    Marker(
                      point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
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
            onPressed: () {
              if (_currentPosition == null) {
                getLocation();
              } else {
                setState(() => _currentPosition = null);
                mapController.move(_kDefaultLatLng, _kDefaultZoom);
              }
            },
            child: Center(
              child: loadingLocation
                  ? const CircularProgressIndicator()
                  : _currentPosition != null
                      ? const Icon(Icons.place, color: Colors.orange)
                      : const Icon(Icons.place_outlined, color: Colors.grey),
            ),
          ),
        ),

        // find location button
        Positioned(
          right: 16,
          bottom: 15,
          child: FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CreatePullPointScreen(),
                ),
              );
            },
            child: const Center(
              child: Text(
                "+PP",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),

        // // filters button
        // Positioned(
        //   right: 16,
        //   bottom: 150,
        //   child: FloatingActionButton(
        //     backgroundColor: Colors.white,
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute<void>(
        //           builder: (BuildContext context) => const MapFiltersScreen(),
        //         ),
        //       );
        //     },
        //     child: const Center(
        //       child: Icon(Icons.filter_alt_outlined, color: Colors.grey),
        //     ),
        //   ),
        // ),

        // pp bs
        BlocBuilder<PullPointsBloc, PullPointsState>(builder: (context, state) {
          if (state is SelectedState) {
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
    );
  }
}
