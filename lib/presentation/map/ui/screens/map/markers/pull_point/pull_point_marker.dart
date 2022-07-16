import 'package:flutter/material.dart' show Icons, Colors;
import 'package:flutter/widgets.dart';
import '../../../../../../../domain/models/models.dart';

class PullPointMarker extends StatelessWidget {
  const PullPointMarker({
    required this.isSelected,
    required this.zoom,
    required this.pullPoint,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final double zoom;
  final PullPointModel pullPoint;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
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
