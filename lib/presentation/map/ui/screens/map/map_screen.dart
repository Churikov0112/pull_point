import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../blocs/blocs.dart';
import 'marker_layer_widget/pull_point_bottom_sheet/pull_point_bottom_sheet.dart';
import 'marker_layer_widget/pull_points_layer_widget.dart';

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
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: _kMapOptions,
          children: [
            TileLayerWidget(options: _kTileLayerOptions),
            PullPointsLayerWidget(mapController: mapController),
          ],
        ),
        BlocBuilder<PullPointsBloc, PullPointsState>(builder: (context, state) {
          print(state.runtimeType);
          if (state is SelectedState) {
            return PullPointBottomSheet(pullPoint: state.selectedPullPoint);
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

// https://www.openstreetmap.org/#map=6/51.944/25.917
