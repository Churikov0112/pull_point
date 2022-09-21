import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:pull_point/presentation/ui_kit/colors/colors.dart';

import '../../../../../../../domain/models/models.dart';

Color _getColorByMetroLine(MetroLines line) {
  switch (line) {
    case MetroLines.firstRed:
      return Colors.red;
    case MetroLines.secondBlue:
      return Colors.blue;
    case MetroLines.thirdGreen:
      return Colors.green;
    case MetroLines.fourthOrange:
      return Colors.orange;
    case MetroLines.fifthPurple:
      return Colors.deepPurple;
    default:
      return Colors.transparent;
  }
}

class MetroStationMarker extends StatelessWidget {
  const MetroStationMarker({
    required this.zoom,
    required this.metro,
    Key? key,
  }) : super(key: key);

  final double zoom;
  final MetroStationModel metro;

  @override
  Widget build(BuildContext context) {
    if (zoom > 12) {
      return Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getColorByMetroLine(metro.line).withOpacity(0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Image.asset(
              "assets/raster/images/metro_logo.png",
              color: AppColors.textOnColors,
            ),
            // AppSubtitle2("м", textColor: AppColors.textOnColors),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
