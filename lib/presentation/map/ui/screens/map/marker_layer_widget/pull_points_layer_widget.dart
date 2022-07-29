import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../../domain/domain.dart';
import '../../../../blocs/blocs.dart';
import '../markers/markers.dart';

class PullPointsLayerWidget extends StatefulWidget {
  const PullPointsLayerWidget({
    required this.mapController,
    Key? key,
  }) : super(key: key);

  final MapController mapController;

  @override
  State<PullPointsLayerWidget> createState() => _PullPointsLayerWidgetState();
}

class _PullPointsLayerWidgetState extends State<PullPointsLayerWidget> {
  late PullPointsBloc pullPointsBloc;

  @override
  void initState() {
    super.initState();

    // load data only firstly
    pullPointsBloc = context.read<PullPointsBloc>();
    if (pullPointsBloc.state is InitialState) {
      pullPointsBloc.add(const LoadDataEvent());
    }

    final state = pullPointsBloc.state;

    if (state is SelectedState) {
      zoomToSpecificPullPoint(latLng: state.selectedPullPoint.geo.latLng);
    }
  }

  void zoomToSpecificPullPoint({LatLng? latLng}) {
    if (latLng != null) {
      widget.mapController.move(latLng, 18);
    }
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
            height: 50,
            width: 50,
            point: notselectedPullPoint.geo.latLng,
            builder: (context) => PullPointMarker(
              zoom: widget.mapController.zoom,
              isSelected: false,
              pullPoint: notselectedPullPoint,
              onTap: () {
                pullPointsBloc.add(const UnselectPullPointEvent());
                pullPointsBloc.add(SelectPullPointEvent(selectedPullPointId: notselectedPullPoint.id));
                zoomToSpecificPullPoint(latLng: notselectedPullPoint.geo.latLng);
              },
            ),
          ),
        );
      }
      pullPointMarkersIfSelected.add(
        Marker(
          height: 50,
          width: 50,
          point: selectedPullPoint.geo.latLng,
          builder: (context) => PullPointMarker(
            zoom: widget.mapController.zoom,
            isSelected: true,
            pullPoint: selectedPullPoint,
          ),
        ),
      );
    } else {
      for (final notselectedPullPoint in notSelectedPullPoints) {
        pullPointMarkersIfNotSelected.add(
          Marker(
            height: 50,
            width: 50,
            point: notselectedPullPoint.geo.latLng,
            builder: (context) => PullPointMarker(
              zoom: widget.mapController.zoom,
              isSelected: false,
              pullPoint: notselectedPullPoint,
              onTap: () {
                pullPointsBloc.add(const UnselectPullPointEvent());
                pullPointsBloc.add(SelectPullPointEvent(selectedPullPointId: notselectedPullPoint.id));
                zoomToSpecificPullPoint(latLng: notselectedPullPoint.geo.latLng);
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
    if (pullPointsBloc.state is SelectedState) {
      pullPointsBloc.add(const UnselectPullPointEvent());
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullPointsBloc, PullPointsState>(
      builder: (context, state) {
        return GroupLayerWidget(
          options: GroupLayerOptions(
            group: [
              if (state is LoadedState)
                pullPointMarkers(null, state.pullPoints)
              else if (state is SelectedState)
                pullPointMarkers(state.selectedPullPoint, state.otherPullPoints),
            ],
          ),
        );
      },
    );
  }
}
