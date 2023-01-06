import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_point/presentation/ui_kit/colors/colors.dart';

import '../../../../../../../domain/models/models.dart';
import '../../../../../../static_methods/static_methods.dart';
import '../../../../../../ui_kit/ui_kit.dart';

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
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        BotToast.showAttachedWidget(
          onClose: () {},
          targetContext: context,
          preferDirection: PreferDirection.topCenter,
          animationDuration: Duration.zero,
          attachedBuilder: (void Function() cancelFunc) {
            return Container(
              transform: Matrix4.translationValues(0.0, -16.0, 0.0),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: TouchableOpacity(
                  onPressed: () {
                    if (onTap != null) {
                      onTap!();
                    }
                    BotToast.cleanAll();
                  },
                  child: SizedBox(
                    // height: 200,
                    width: mediaQuery.size.width * 0.5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: AppColors.backgroundCard),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CategoryChip(
                                gradient: AppGradients.main,
                                childText: pullPoint.category.name,
                              ),
                              const SizedBox(height: 8),
                              AppSubtitle(
                                pullPoint.owner.name ?? "-",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              AppSubtitle2(
                                pullPoint.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              AppSubtitle2(
                                "Будет идти еще ${StaticMethods.durationInHoursAndMinutes(pullPoint.endsAt.difference(DateTime.now()))}",
                                textColor: AppColors.success,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: isSelected
          ? const DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.main,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.place,
                  size: 24,
                  color: AppColors.iconsOnColors,
                ),
              ),
            )
          : const DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppGradients.first,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.place,
                  size: 24,
                  color: AppColors.iconsOnColors,
                ),
              ),
            ),
      //  Icon(
      //   Icons.place,
      //   size: 50,
      //   color: isSelected ? Colors.red : Colors.orange,
      // ),
    );
  }
}
