import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../domain/models/models.dart';
import '../../../../../../../ui_kit/ui_kit.dart';
import '../../../../../../blocs/blocs.dart';

class PullPointBottomSheetContent extends StatelessWidget {
  const PullPointBottomSheetContent({
    Key? key,
    required this.pullPoint,
  }) : super(key: key);

  final PullPointModel pullPoint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pullPoint.artist.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
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
    );
  }
}
