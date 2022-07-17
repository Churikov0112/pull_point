// import 'package:flutter/material.dart' show Colors;
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../domain/models/models.dart';
// import '../../../../home/blocs/blocs.dart';
// import '../../../../map/blocs/blocs.dart';
// import '../../../../ui_kit/ui_kit.dart';

// class PosterItem extends StatelessWidget {
//   const PosterItem({
//     required this.pullPoint,
//     Key? key,
//   }) : super(key: key);

//   final PullPointModel pullPoint;

//   @override
//   Widget build(BuildContext context) {
//     return TouchableOpacity(
//       onPressed: () {
//         context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
//         context.read<HomeBloc>().add(const SelectTabEvent(tabIndex: 0));
//       },
//       child: Container(
//         decoration: const BoxDecoration(color: Colors.amber),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("pull point id: ${pullPoint.id}"),
//               // Text("Место: ${state.pullPoints[index].address}"),
//               // Text("Название: ${state.pullPoints[index].title}"),
//               // Text("Широта: ${state.pullPoints[index].latLng.latitude}"),
//               // Text("Долгота: ${state.pullPoints[index].latLng.longitude}"),
//               // Text("Дата начала: ${state.pullPoints[index].createdAt}"),
//               // Text("Дата конца: ${state.pullPoints[index].expireAt}"),
//               // Text("ID артиста: ${state.pullPoints[index].artist.name}"),
//               // Text("Имя артиста: ${state.pullPoints[index].artist.name}"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/models/models.dart';
import '../../../../home/blocs/blocs.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';

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
        context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
        context.read<HomeBloc>().add(const SelectTabEvent(tabIndex: 0));
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
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.8),
                      Color.fromRGBO(0, 0, 0, 0),
                    ],
                  ),
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
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Начало: ${DateFormat("dd.MM.yyyy HH.mm").format(pullPoint.startsAt)}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Конец: ${DateFormat("dd.MM.yyyy HH.mm").format(pullPoint.endsAt)}",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
