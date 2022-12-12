import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../domain/models/models.dart';
import '../../../../blocs/blocs.dart';
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

    print(pullPoint.startsAt.toLocal());
    print(DateTime.now().toLocal());
    print(pullPoint.startsAt.toLocal().isBefore(DateTime.now().toLocal()));

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
                    // Container(
                    //   height: 112,
                    //   width: 112,
                    //   decoration: const BoxDecoration(
                    //     color: Color.fromRGBO(108, 108, 108, 1),
                    //     borderRadius: BorderRadius.all(Radius.circular(12)),
                    //   ),
                    //   child: const Center(child: Text("Фото")),
                    // ),
                    // const SizedBox(width: 16),
                    Container(
                      height: 112,
                      width: 2,
                      decoration: BoxDecoration(
                        color: StaticMethods.isPullPointGoingNow(pullPoint) ? AppColors.success : AppColors.error,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 112,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: mediaqQuery.size.width - 90,
                            child: AppTitle(pullPoint.title),
                          ),
                          AppText(pullPoint.owner.name ?? "-"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    StaticMethods.isPullPointGoingNow(pullPoint)
                                        ? "Будет идти еще ${StaticMethods.durationInHoursAndMinutes(pullPoint.endsAt.difference(DateTime.now()))}"
                                        : "Начнется ${DateFormat("dd.MM.yyyy в HH:mm").format(pullPoint.startsAt)}",
                                    textColor: StaticMethods.isPullPointGoingNow(pullPoint)
                                        ? AppColors.success
                                        : AppColors.error,
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
                const AppTitle("Описание"),
                const SizedBox(height: 8),
                AppText(pullPoint.description),
                const SizedBox(height: 16),
                const AppTitle("Артисты"),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: CategoryChip(
                    gradient: AppGradients.main,
                    childText: pullPoint.owner.name ?? "-",
                  ),
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
                  width: mediaqQuery.size.width,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CategoryChip(
                          gradient: AppGradients.first,
                          childText: pullPoint.category.name,
                        ),
                      ),
                      for (final subcategory in pullPoint.subcategories)
                        GestureDetector(
                          onTap: () {},
                          child: CategoryChip(
                            gradient: AppGradients.first,
                            childText: subcategory.name,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (pullPoint.nearestMetroStations.isNotEmpty) const AppTitle("Метро рядом"),
                if (pullPoint.nearestMetroStations.isNotEmpty) const SizedBox(height: 8),
                if (pullPoint.nearestMetroStations.isNotEmpty)
                  SizedBox(
                    width: mediaqQuery.size.width,
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
                if (StaticMethods.isPullPointGoingNow(pullPoint))
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TouchableOpacity(
                        onPressed: () {
                          context.read<PullPointsBloc>().add(SelectPullPointEvent(selectedPullPointId: pullPoint.id));
                          context.read<HomeBloc>().add(const HomeEventSelectTab(tabIndex: 0));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
