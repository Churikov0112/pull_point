import 'package:flutter/material.dart';
import 'package:pull_point/presentation/map/ui/screens/map/marker_layer_widget/pull_point_bottom_sheet/widgets/pull_point_bottom_sheet_content.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../../domain/models/models.dart';
import 'widgets/widgets.dart';

class PullPointBottomSheet extends StatelessWidget {
  final PullPointModel pullPoint;

  final Function()? onClose;

  const PullPointBottomSheet({
    required this.pullPoint,
    this.onClose,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      bottom: false,
      child: SlidingUpPanel(
        minHeight: 120,
        maxHeight: mediaQuery.size.height - mediaQuery.padding.top - 56,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        parallaxEnabled: true,
        parallaxOffset: 0.1,
        panelBuilder: (scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                PullPointBottomSheetHeader(pullPoint: pullPoint, onClose: onClose),
                PullPointBottomSheetContent(pullPoint: pullPoint, scrollController: scrollController),
              ],
            ),
          );
        },
      ),
    );
  }
}
