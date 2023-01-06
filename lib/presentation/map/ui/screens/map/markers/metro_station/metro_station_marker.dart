import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../../../domain/models/models.dart';
import '../../../../../../ui_kit/colors/app_colors.dart';
import '../../../../../../ui_kit/text/text.dart';

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
      return TouchableOpacity(
        onPressed: () {
          BotToast.showAttachedWidget(
            onClose: () {},
            targetContext: context,
            preferDirection: PreferDirection.topCenter,
            animationDuration: Duration.zero,
            attachedBuilder: (void Function() cancelFunc) {
              return Container(
                transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppSubtitle(
                      metro.title,
                      textColor: _getColorByMetroLine(metro.line),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _getColorByMetroLine(metro.line),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              "assets/raster/images/metro_logo.png",
              color: AppColors.backgroundCard,
              height: 24,
              width: 24,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
