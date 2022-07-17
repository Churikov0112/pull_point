import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

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
    pullPointsBloc = context.read<PullPointsBloc>();
    if (pullPointsBloc.state is InitialState) {
      pullPointsBloc.add(LoadDataEvent());
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
            point: notselectedPullPoint.latLng,
            builder: (context) => PullPointMarker(
              zoom: widget.mapController.zoom,
              isSelected: false,
              pullPoint: notselectedPullPoint,
              onTap: () {
                pullPointsBloc.add(UnselectPullPointEvent());
                pullPointsBloc.add(SelectPullPointEvent(selectedPullPointId: notselectedPullPoint.id));
              },
            ),
          ),
        );
      }
      pullPointMarkersIfSelected.add(
        Marker(
          height: 50,
          width: 50,
          point: selectedPullPoint.latLng,
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
            point: notselectedPullPoint.latLng,
            builder: (context) => PullPointMarker(
              zoom: widget.mapController.zoom,
              isSelected: false,
              pullPoint: notselectedPullPoint,
              onTap: () {
                pullPointsBloc.add(UnselectPullPointEvent());
                pullPointsBloc.add(SelectPullPointEvent(selectedPullPointId: notselectedPullPoint.id));
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
      pullPointsBloc.add(UnselectPullPointEvent());
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
