import 'package:flutter/material.dart' show Divider, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/models/models.dart';
import '../../../../../blocs/blocs.dart';
import '../../../../../ui_kit/ui_kit.dart';

class PullPointBottomSheetHeader extends StatelessWidget {
  const PullPointBottomSheetHeader({
    required this.pullPoint,
    this.onClose,
    Key? key,
  }) : super(key: key);

  final PullPointModel pullPoint;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mediaQuery.size.width * 0.85,
                    child: AppTitle(
                      pullPoint.title,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: mediaQuery.size.width * 0.85,
                    child: AppText(
                      pullPoint.owner.name ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              TouchableOpacity(
                onPressed: () {
                  if (onClose != null) {
                    onClose!();
                  }
                  context.read<PullPointsBloc>().add(const UnselectPullPointEvent());
                },
                child: const SizedBox.square(
                  dimension: 32,
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }
}
