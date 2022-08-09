import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import '../../../../../../../domain/models/models.dart';
import '../../../../../../ui_kit/ui_kit.dart';

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
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getColorByMetroLine(metro.line).withOpacity(0.8),
        ),
        child: const Center(child: AppSubtitle2("м", textColor: AppColors.textOnColors)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
