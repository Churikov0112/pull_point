import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/models.dart';
import '../../../../home/blocs/blocs.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';

class PosterItem extends StatelessWidget {
  const PosterItem({
    required this.pullPoint,
    Key? key,
  }) : super(key: key);

  final PullPointModel pullPoint;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: () {
        context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
        context.read<HomeBloc>().add(const SelectTabEvent(tabIndex: 0));
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.amber),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("pull point id: ${pullPoint.id}"),
              // Text("Место: ${state.pullPoints[index].address}"),
              // Text("Название: ${state.pullPoints[index].title}"),
              // Text("Широта: ${state.pullPoints[index].latLng.latitude}"),
              // Text("Долгота: ${state.pullPoints[index].latLng.longitude}"),
              // Text("Дата начала: ${state.pullPoints[index].createdAt}"),
              // Text("Дата конца: ${state.pullPoints[index].expireAt}"),
              // Text("ID артиста: ${state.pullPoints[index].artist.name}"),
              // Text("Имя артиста: ${state.pullPoints[index].artist.name}"),
            ],
          ),
        ),
      ),
    );
  }
}
