import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../../domain/models/models.dart';
import 'widgets/widgets.dart';

class PullPointBottomSheet extends StatelessWidget {
  final PullPointModel pullPoint;

  const PullPointBottomSheet({
    required this.pullPoint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return SlidingUpPanel(
      minHeight: 70,
      panel: Column(
        children: [
          PullPointBottomSheetHeader(pullPoint: pullPoint),
        ],
      ),
    );

    // DraggableScrollableSheet(
    //   minChildSize: 0.15,
    //   initialChildSize: 0.15,
    //   builder: (BuildContext context, ScrollController scrollController) {
    //     return SingleChildScrollView(
    //       physics: const ClampingScrollPhysics(),
    //       controller: scrollController,
    //       child: Container(
    //         height: mediaQuery.size.height * 0.9,
    //         decoration: const BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(24),
    //             topRight: Radius.circular(24),
    //           ),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(16.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               Text(
    //                 pullPoint.artist.name,
    //                 style: const TextStyle(fontSize: 24),
    //               ),
    //               const SizedBox(height: 16),
    //               Text(
    //                 'Где: ${pullPoint.address}',
    //                 style: const TextStyle(fontSize: 16),
    //               ),
    //               const SizedBox(height: 8),
    //               Text(
    //                 'Начало: ${DateFormat("HH:mm").format(pullPoint.createdAt)}',
    //                 style: const TextStyle(fontSize: 16),
    //               ),
    //               const SizedBox(height: 8),
    //               Text(
    //                 'Закончится: ${DateFormat("HH:mm").format(pullPoint.expireAt)}',
    //                 style: const TextStyle(fontSize: 16),
    //               ),
    //               const SizedBox(height: 16),
    //               Image.network('https://spb.arttube.ru/wp-content/uploads/sites/5/2019/07/STREET-MUSIC-FEST.jpg'),
    //               const SizedBox(height: 32),
    //               TouchableOpacity(
    //                 onPressed: () {},
    //                 child: Container(
    //                   width: mediaQuery.size.width,
    //                   height: 50,
    //                   decoration: const BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(12)),
    //                     color: Colors.orange,
    //                   ),
    //                   child: const Center(
    //                     child: Text(
    //                       'Пожертвовать',
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
