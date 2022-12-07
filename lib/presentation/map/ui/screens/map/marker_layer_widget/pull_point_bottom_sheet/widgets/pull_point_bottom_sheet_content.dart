import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../domain/models/models.dart';
import '../../../../../../../static_methods/static_methods.dart';
import '../../../../../../../ui_kit/ui_kit.dart';

// bool _isActive({
//   required PullPointModel pp,
// }) {
//   if (pp.startsAt.isBefore(DateTime.now()) && pp.endsAt.isAfter(DateTime.now())) {
//     return true;
//   }
//   return false;
// }

class PullPointBottomSheetContent extends StatelessWidget {
  const PullPointBottomSheetContent({
    Key? key,
    required this.pullPoint,
    required this.scrollController,
  }) : super(key: key);

  final PullPointModel pullPoint;
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
            const AppTitle("Описание"),
            const SizedBox(height: 8),
            AppText(pullPoint.description),
            const SizedBox(height: 16),
            const AppTitle("Артисты"),
            const SizedBox(height: 8),
            CategoryChip(
              gradient: AppGradients.main,
              childText: pullPoint.owner.name ?? "-",
            ),
            const SizedBox(height: 16),
            const AppTitle("Время начала и конца"),
            const SizedBox(height: 8),
            AppText("Начало: ${DateFormat("dd.MM.yyyy в HH:mm").format(pullPoint.startsAt)}"),
            const SizedBox(height: 8),
            AppText("Конец: ${DateFormat("dd.MM.yyyy в HH:mm").format(pullPoint.endsAt)}"),
            const SizedBox(height: 16),
            const AppTitle("Категории"),
            const SizedBox(height: 8),
            SizedBox(
              width: mediaQuery.size.width,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  CategoryChip(
                    gradient: AppGradients.first,
                    childText: pullPoint.category.name,
                  ),
                  for (final subcategory in pullPoint.subcategories)
                    CategoryChip(
                      gradient: AppGradients.first,
                      childText: subcategory.name,
                    ),
                ],
              ),
            ),
            if (pullPoint.nearestMetroStations.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const AppTitle("Метро рядом"),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: mediaQuery.size.width,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final metroStation in pullPoint.nearestMetroStations)
                          ChipWithChild(
                            backgroundColor: StaticMethods.getColorByMetroLine(metroStation.line),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(metroStation.title, textColor: AppColors.textOnColors),
                                const SizedBox(width: 8),
                                Image.asset(
                                  "assets/raster/images/metro_logo.png",
                                  height: 16,
                                  width: 16,
                                  color: AppColors.iconsOnColors,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: LongButton(
                onTap: () {},
                backgroundColor: AppColors.orange,
                child: const AppText("Пожертвовать", textColor: AppColors.textOnColors),
              ),
            ),

            //   if (_isActive(pp: pullPoint))
            //     AppText(
            //       "Выступление будет идти еще ${StaticMethods.durationInHoursAndMinutes(pullPoint.endsAt.difference(DateTime.now()))}",
            //       textColor: _isActive(pp: pullPoint) ? Colors.green : Colors.red,
            //     ),
            //   const SizedBox(height: 16),
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "Описание выступления",
            //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(pullPoint.description),
            //       const SizedBox(height: 16),
            //     ],
            //   ),
            //   if (pullPoint.posterUrl != null)
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           "Афиша",
            //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //         ),
            //         const SizedBox(height: 16),
            //         Image.network(
            //           pullPoint.posterUrl!,
            //           width: mediaQuery.size.width,
            //         ),
            //         const SizedBox(height: 16),
            //       ],
            //     ),
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "Описание артиста",
            //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 8),
            //       Text(pullPoint.owner.description ?? "-"),
            //       const SizedBox(height: 16),
            //     ],
            //   ),
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "Как найти",
            //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 8),
            //       Text("Время: ${DateFormat('HH:mm').format(pullPoint.startsAt)}"),
            //       const SizedBox(height: 8),
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text("Метро: "),
            //           Column(
            //             children: [
            //               for (final metro in MetroStations.getNearestMetroStations(latLng: pullPoint.geo.latLng))
            //                 Text(metro.title),
            //             ],
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            //   const SizedBox(height: 32),
            //   TouchableOpacity(
            //     onPressed: () {},
            //     child: Container(
            //       width: mediaQuery.size.width,
            //       height: 50,
            //       decoration: const BoxDecoration(
            //         color: Colors.orange,
            //         borderRadius: BorderRadius.all(Radius.circular(12)),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           "Пожертвовать",
            //           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            //         ),
            //       ),
            //     ),
            //   ),
            //   const SizedBox(height: 16),
            //   TouchableOpacity(
            //     onPressed: () {},
            //     child: Container(
            //       width: mediaQuery.size.width,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         color: Colors.orange.withOpacity(0.2),
            //         borderRadius: const BorderRadius.all(Radius.circular(12)),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           "На страницу артиста",
            //           style: TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.w500),
            //         ),
            //       ),
            //     ),
            //   ),
            //   const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
