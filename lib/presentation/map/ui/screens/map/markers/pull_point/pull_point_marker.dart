import 'package:flutter/material.dart' show Icons, Colors;
import 'package:flutter/widgets.dart';
import '../../../../../../../domain/models/models.dart';

class PullPointMarker extends StatelessWidget {
  const PullPointMarker({
    required this.isSelected,
    required this.zoom,
    required this.pullPoint,
    this.onNotselectedPullPointMarkerTap,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final double zoom;
  final PullPointModel pullPoint;
  final Function()? onNotselectedPullPointMarkerTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onNotselectedPullPointMarkerTap != null) {
          onNotselectedPullPointMarkerTap!();
        }
      },
      child: Icon(
        Icons.place,
        size: 50,
        color: isSelected ? Colors.red : Colors.orange,
      ),
    );
  }
}
