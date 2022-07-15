import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../blocs/blocs.dart';

class MarkerLayerWidget extends StatefulWidget {
  const MarkerLayerWidget({
    required this.mapController,
    Key? key,
  }) : super(key: key);

  final MapController mapController;

  @override
  State<MarkerLayerWidget> createState() => _MarkerLayerWidgetState();
}

class _MarkerLayerWidgetState extends State<MarkerLayerWidget> {
  late PullPointsBloc pullPointsBloc;

  @override
  void initState() {
    super.initState();

    pullPointsBloc.add(const PullPointsEvent.load());
  }

  LayerOptions pullPointMarkers(
    PullPointModel? selectedPullPoint,
    List<PullPointModel> notSelectedPullPoints,
  ) {
    final List<Marker> pullPointMarkersIfSelected = [];
    final List<Marker> pullPointMarkersIfNotSelected = [];
    if (selectedPullPoint != null) {
      for (final notselectedPullPoint in notSelectedPullPoints) {
        pullPointMarkersIfSelected.add(
          Marker(
            height: 26,
            width: 20,
            point: LatLng(notselectedPullPoint.coordinate!.latitude, notselectedPullPoint.coordinate!.longitude),
            builder: (context) => PullPointMarker(
              zoom: widget.mapController.zoom,
              isSelected: false,
              place: notselectedPullPoint,
              onNotselectedPullPointMarkerTap: () {
                pullPointsBloc.add(
                  PullPointsEvent.choose(
                    chosenPlaceId: notselectedPullPoint.id,
                    cityId: null,
                  ),
                );
              },
            ),
          ),
        );
      }
      pullPointMarkersIfSelected.add(
        Marker(
          height: 51,
          width: 32,
          point: LatLng(selectedPullPoint.coordinate!.latitude, selectedPullPoint.coordinate!.longitude),
          builder: (context) => PullPointMarker(
            zoom: widget.mapController.zoom,
            isSelected: true,
            place: selectedPullPoint,
          ),
        ),
      );
    } else {
      for (final notselectedPullPoint in notSelectedPullPoints) {
        pullPointMarkersIfNotSelected.add(
          Marker(
            height: 26,
            width: 20,
            point: LatLng(notselectedPullPoint.coordinate!.latitude, notselectedPullPoint.coordinate!.longitude),
            builder: (context) => PullPointMarker(
              zoom: widget.mapController.zoom,
              isSelected: false,
              place: notselectedPullPoint,
              onNotselectedPullPointMarkerTap: () {
                pullPointsBloc.add(
                  PullPointsEvent.choose(
                    chosenPlaceId: notselectedPullPoint.id,
                    cityId: null,
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    final markers = MarkerLayerOptions(
      rotate: true,
      markers: [
        if (selectedPullPoint != null) ...pullPointMarkersIfSelected else ...pullPointMarkersIfNotSelected,
      ],
    );
    return markers;
  }

  @override
  void deactivate() {
    if (pullPointsBloc.state is PullPointStateChosen) {
      pullPointsBloc.add(const PullPointsEvent.reset());
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullPointsBloc, PullPointState>(
      builder: (context, state) {
        return GroupLayerWidget(
          options: GroupLayerOptions(
            group: [
              if (state is PullPointStateLoadSucceeded)
                pullPointMarkers(null, state.pullPoints)
              else if (state is PullPointStateChosen)
                pullPointMarkers(state.chosenPullPoint, state.otherPullPoints),
            ],
          ),
        );
      },
    );
  }
}
