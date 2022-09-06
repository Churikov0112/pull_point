import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../domain/models/models.dart';
import '../../../../home/blocs/blocs.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../../static_methods/static_methods.dart';
import '../../../../ui_kit/ui_kit.dart';

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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppTitle(pullPoint.title),
                          AppText(pullPoint.owner.name ?? "-"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    StaticMethods.isPullPointGoingNow(pullPoint) ? "Уже идет" : "Еще не началось",
                                    textColor: StaticMethods.isPullPointGoingNow(pullPoint) ? AppColors.success : AppColors.error,
                                  ),
                                  if (userLocation != null) const SizedBox(width: 12),
                                  if (userLocation != null)
                                    AppText(
                                        "${StaticMethods.distanceInKmBetweenEarthCoordinates(pullPoint.geo.latLng.latitude, pullPoint.geo.latLng.longitude, userLocation!.latitude, userLocation!.longitude).toStringAsFixed(1)} км"),
                                ],
                              )
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
                const SizedBox(height: 16),

                SizedBox(
                  width: mediaqQuery.size.width,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      CategoryChip(
                        gradient: AppGradients.main,
                        childText: pullPoint.category.name,
                        onPressed: () {},
                      ),
                      for (final subcategory in pullPoint.subcategories)
                        CategoryChip(
                          gradient: AppGradients.first,
                          childText: subcategory.name,
                          onPressed: () {},
                        ),
                      for (final metroStation in pullPoint.nearestMetroStations)
                        CategoryChip(
                          backgroundColor: StaticMethods.getColorByMetroLine(metroStation.line),
                          childText: metroStation.title,
                          onPressed: () {},
                        ),
                    ],
                  ),
                ),

                if (StaticMethods.isPullPointGoingNow(pullPoint))
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
                          // ClipRRect(
                          //   borderRadius: const BorderRadius.all(Radius.circular(100)),
                          //   child: pullPoint.artists.first.avatar != null
                          //       ? Image.network(
                          //           pullPoint.artists.first.avatar!,
                          //           height: 40,
                          //           width: 40,
                          //           fit: BoxFit.cover,
                          //         )
                          //       : Container(
                          //           height: 40,
                          //           width: 40,
                          //           decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                          //         ),
                          // ),
                          // const SizedBox(width: 8),
                          AppText(pullPoint.owner.name ?? "-", textColor: AppColors.textOnColors),
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
