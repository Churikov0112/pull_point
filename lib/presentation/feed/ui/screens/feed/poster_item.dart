import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/models/models.dart';
import '../../../../home/blocs/blocs.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';

bool isActive({
  required PullPointModel pp,
}) {
  if (pp.startsAt.isBefore(DateTime.now()) && pp.endsAt.isAfter(DateTime.now())) {
    return true;
  }
  return false;
}

class PosterItem extends StatelessWidget {
  final PullPointModel pullPoint;

  const PosterItem({
    required this.pullPoint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaqQuery = MediaQuery.of(context);
    return TouchableOpacity(
      onPressed: () {
        if (isActive(pp: pullPoint)) {
          context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
          context.read<HomeBloc>().add(const SelectTabEvent(tabIndex: 0));
        } else {
          var cancel = BotToast.showText(text: "Это выступление еще не началось");
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Stack(
          children: [
            SizedBox(
              height: mediaqQuery.size.width / 2,
              width: mediaqQuery.size.width / 2,
              child: pullPoint.posterUrl != null
                  ? Image.network(
                      pullPoint.posterUrl!,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            // Накладывает opacity поверх всех виджетов и изображения
            // в карточке, для затемнения
            SizedBox(
              height: mediaqQuery.size.width / 2,
              width: mediaqQuery.size.width / 2,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
            SizedBox(
              height: mediaqQuery.size.width / 2,
              width: mediaqQuery.size.width / 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pullPoint.title,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Начало: ${DateFormat("dd.MM.yyyy HH.mm").format(pullPoint.startsAt)}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Место: ${pullPoint.address}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Text(
                pullPoint.artist.name,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
