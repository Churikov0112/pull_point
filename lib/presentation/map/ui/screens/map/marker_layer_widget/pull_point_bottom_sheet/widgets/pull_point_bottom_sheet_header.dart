import 'package:flutter/material.dart' show Colors, Divider, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../domain/models/models.dart';
import '../../../../../../../ui_kit/ui_kit.dart';
import '../../../../../../blocs/blocs.dart';

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
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pullPoint.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pullPoint.owner.name ?? "-",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
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
        ),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }
}
