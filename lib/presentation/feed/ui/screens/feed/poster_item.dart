import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../domain/models/models.dart';
import '../../../../home/blocs/blocs.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';

bool _isActive(PullPointModel pp) {
  if (pp.startsAt.isBefore(DateTime.now()) && pp.endsAt.isAfter(DateTime.now())) {
    return true;
  }
  return false;
}

double _degreesToRadians(degrees) {
  return degrees * pi / 180;
}

double _distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = _degreesToRadians(lat2 - lat1);
  var dLon = _degreesToRadians(lon2 - lon1);

  lat1 = _degreesToRadians(lat1);
  lat2 = _degreesToRadians(lat2);

  var a = sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadiusKm * c;
}

Color _getColorByMetroLine(MetroLines line) {
  switch (line) {
    case MetroLines.firstRed:
      return Colors.red;
    case MetroLines.secondBlue:
      return Colors.blue;
    case MetroLines.thirdGreen:
      return Colors.green;
    case MetroLines.fourthOrange:
      return Colors.deepOrange;
    case MetroLines.fifthPurple:
      return Colors.deepPurple;
    default:
      return Colors.transparent;
  }
}

class PosterItemV2 extends StatelessWidget {
  final PullPointModel pullPoint;
  final LatLng? userLocation;

  const PosterItemV2({
    required this.pullPoint,
    this.userLocation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaqQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.backgroundCard,
        ),
        child: ExpandableContainer(
          collapsed: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 112,
                      width: 112,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(108, 108, 108, 1),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Center(child: Text("Фото")),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 112,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: mediaqQuery.size.width / 2, child: AppTitle(pullPoint.title)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    _isActive(pullPoint) ? "Уже идет" : "Еще не началось",
                                    textColor: _isActive(pullPoint) ? AppColors.success : AppColors.error,
                                  ),
                                  if (userLocation != null) const SizedBox(width: 16),
                                  if (userLocation != null)
                                    AppText(
                                        "${_distanceInKmBetweenEarthCoordinates(pullPoint.geo.latLng.latitude, pullPoint.geo.latLng.longitude, userLocation!.latitude, userLocation!.longitude).toStringAsFixed(0)} м"),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: mediaqQuery.size.width / 2,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (int i = 0; i < 3; i++)
                                      CategoryChip(
                                        gradient: AppGradients.first,
                                        childText: "some",
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          expanded: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(pullPoint.description),
                if (_isActive(pullPoint))
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TouchableOpacity(
                        onPressed: () {
                          context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
                          context.read<HomeBloc>().add(const SelectTabEvent(tabIndex: 0));
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          child: Image.asset(
                            "assets/raster/images/map_preview.png",
                            height: 112,
                            width: mediaqQuery.size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                if (pullPoint.nearestMetroStations.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        width: mediaqQuery.size.width,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (int i = 0; i < pullPoint.nearestMetroStations.length; i++)
                              CategoryChip(
                                backgroundColor: _getColorByMetroLine(pullPoint.nearestMetroStations[i].line),
                                childText: pullPoint.nearestMetroStations[i].title,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 16),
                AppText("Начало: ${DateFormat("dd.MM.yyyy в HH:mm").format(pullPoint.startsAt)}"),
                const SizedBox(height: 16),
                AppText("Конец: ${DateFormat("dd.MM.yyyy в HH:mm").format(pullPoint.endsAt)}"),
                const SizedBox(height: 16),
                TouchableOpacity(
                  onPressed: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: AppGradients.main,
                      // color: AppColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            child: pullPoint.artists.first.avatar != null
                                ? Image.network(
                                    pullPoint.artists.first.avatar!,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                                  ),
                          ),
                          const SizedBox(width: 8),
                          AppText(pullPoint.artists.first.name, textColor: AppColors.textOnColors),
                        ],
                      ),
                    ),
                  ),
                ),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class PosterItem extends StatelessWidget {
//   final PullPointModel pullPoint;

//   const PosterItem({
//     required this.pullPoint,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final mediaqQuery = MediaQuery.of(context);
//     return TouchableOpacity(
//       onPressed: () async {
//         if (_isActive(pullPoint)) {
//           context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
//           context.read<HomeBloc>().add(const SelectTabEvent(tabIndex: 0));
//         } else {
//           await showModalBottomSheet(
//             isScrollControlled: true,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//             backgroundColor: Colors.transparent,
//             context: context,
//             builder: (BuildContext context) {
//               final scrollController = ScrollController();
//               return SafeArea(
//                 bottom: false,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: mediaqQuery.padding.top),
//                   child: SingleChildScrollView(
//                     controller: scrollController,
//                     child: Column(
//                       children: [
//                         // SizedBox(height: mediaqQuery.padding.top),
//                         PullPointBottomSheetHeader(
//                           pullPoint: pullPoint,
//                           onClose: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         PullPointBottomSheetContent(
//                           pullPoint: pullPoint,
//                           scrollController: ScrollController(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//       child: SizedBox(
//         height: mediaqQuery.size.width / 2,
//         width: mediaqQuery.size.width / 2,
//         child: ClipRRect(
//           borderRadius: const BorderRadius.all(Radius.circular(12)),
//           child: Stack(
//             children: [
//               SizedBox(
//                 height: mediaqQuery.size.width / 2,
//                 width: mediaqQuery.size.width / 2,
//                 child: pullPoint.posterUrl != null
//                     ? Image.network(
//                         pullPoint.posterUrl!,
//                         fit: BoxFit.cover,
//                       )
//                     : null,
//               ),
//               // Накладывает opacity поверх всех виджетов и изображения
//               // в карточке, для затемнения
//               SizedBox(
//                 height: mediaqQuery.size.width / 2,
//                 width: mediaqQuery.size.width / 2,
//                 child: const DecoratedBox(
//                   decoration: BoxDecoration(
//                     // borderRadius: BorderRadius.all(Radius.circular(12)),
//                     color: Color.fromRGBO(0, 0, 0, 0.5),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: mediaqQuery.size.width / 2,
//                 width: mediaqQuery.size.width / 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         pullPoint.title,
//                         maxLines: 2,
//                         style: const TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Начало: ${DateFormat("dd.MM.yyyy HH.mm").format(pullPoint.startsAt)}",
//                         style: const TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Место: ${pullPoint.geo.address}",
//                         style: const TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 12,
//                 left: 12,
//                 child: SizedBox(
//                   width: mediaqQuery.size.width / 2 - 32,
//                   child: Text(
//                     pullPoint.artists.first.name,
//                     maxLines: 2,
//                     style: const TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
