import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../../../../../../../domain/models/models.dart';
import '../../../../../../../ui_kit/ui_kit.dart';

bool isActive({
  required PullPointModel pp,
}) {
  if (pp.startsAt.isBefore(DateTime.now()) && pp.endsAt.isAfter(DateTime.now())) {
    return true;
  }
  return false;
}

class PullPointBottomSheetContent extends StatelessWidget {
  const PullPointBottomSheetContent({
    Key? key,
    required this.pullPoint,
    required this.scrollController,
    required this.nearestMetroStations,
  }) : super(key: key);

  final PullPointModel pullPoint;
  final List<MetroStationModel> nearestMetroStations;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isActive(pp: pullPoint) ? "Выступление уже идет" : "Выступление еще не началось",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isActive(pp: pullPoint) ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Описание выступления",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(pullPoint.description),
                const SizedBox(height: 16),
              ],
            ),
            if (pullPoint.posterUrl != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Афиша",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Image.network(
                    pullPoint.posterUrl!,
                    width: mediaQuery.size.width,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Описание артиста",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(pullPoint.artist.description),
                const SizedBox(height: 16),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Как найти",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Место: ${pullPoint.address}"),
                const SizedBox(height: 8),
                Text("Время: ${DateFormat('HH:mm').format(pullPoint.startsAt)}"),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Метро: "),
                    Column(
                      children: [
                        for (final metro in nearestMetroStations) Text(metro.title),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 32),
            TouchableOpacity(
              onPressed: () {},
              child: Container(
                width: mediaQuery.size.width,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    "Пожертвовать",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TouchableOpacity(
              onPressed: () {},
              child: Container(
                width: mediaQuery.size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    "На страницу артиста",
                    style: TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
