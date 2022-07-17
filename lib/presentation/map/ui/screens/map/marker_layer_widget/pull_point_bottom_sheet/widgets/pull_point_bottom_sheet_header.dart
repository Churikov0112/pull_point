import 'package:flutter/material.dart' show Divider, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../domain/models/models.dart';
import '../../../../../../../ui_kit/ui_kit.dart';
import '../../../../../../blocs/blocs.dart';

class PullPointBottomSheetHeader extends StatelessWidget {
  const PullPointBottomSheetHeader({
    Key? key,
    required this.pullPoint,
  }) : super(key: key);

  final PullPointModel pullPoint;

  @override
  Widget build(BuildContext context) {
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
                    pullPoint.artist.name,
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
                  context.read<PullPointsBloc>().add(UnselectPullPointEvent());
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
