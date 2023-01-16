import 'package:flutter/material.dart' show Colors, InkWell, MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_point/main.dart' as main;
import 'package:pull_point/presentation/artist/artist_guest_screen.dart';
import 'package:pull_point/presentation/blocs/blocs.dart';
import 'package:pull_point/presentation/donation/donation_screen.dart';

import '../../../../../../domain/models/models.dart';
import '../../../../../static_methods/static_methods.dart';
import '../../../../../ui_kit/ui_kit.dart';

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
    return BlocBuilder<UserArtistsBloc, UserArtistsState>(
      builder: (context, state) {
        print(main.userBox.get("user"));
        print(state.runtimeType);
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
                ArtistChip(pullPoint: pullPoint),
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

                if (state is UserArtistsStateSelected)
                  const Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: Center(child: AppText("Это ваше выступление")),
                  )
                else
                  DonateButton(artist: pullPoint.owner),
                // if (main.userBox.get("user") == null)
                //   DonateButton(artist: pullPoint.owner)
                // else if (state is UserArtistsStateSelected)
                //   if (state.allUserArtists.contains(pullPoint.owner))
                //     const Padding(
                //       padding: EdgeInsets.only(top: 32),
                //       child: Center(child: AppText("Это ваше выступление")),
                //     )
                //   else
                //     DonateButton(artist: pullPoint.owner),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DonateButton extends StatelessWidget {
  const DonateButton({
    required this.artist,
    super.key,
  });

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: LongButton(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DonationScreen(artist: artist),
            ),
          );
        },
        backgroundColor: AppColors.orange,
        child: const AppText("Пожертвовать", textColor: AppColors.textOnColors),
      ),
    );
  }
}

class ArtistChip extends StatelessWidget {
  const ArtistChip({
    required this.pullPoint,
    super.key,
  });

  final PullPointModel pullPoint;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserArtistsBloc, UserArtistsState>(
      builder: (context, userArtistsState) {
        return GestureDetector(
          onTap: () {
            if (main.userBox.get("user") == null) {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ArtistGuestScreen(artist: pullPoint.owner),
                ),
              );
            } else if (main.userBox.get("user")!.isArtist != null) {
              if (main.userBox.get("user")!.isArtist! == false) {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ArtistGuestScreen(artist: pullPoint.owner),
                  ),
                );
              } else {
                if (userArtistsState is UserArtistsStateSelected) {
                  if (!userArtistsState.allUserArtists.contains(pullPoint.owner)) {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ArtistGuestScreen(artist: pullPoint.owner),
                      ),
                    );
                  }
                }
              }
            }
          },
          child: CategoryChip(
            gradient: AppGradients.main,
            childText: pullPoint.owner.name ?? "-",
          ),
        );
      },
    );
  }
}
