import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/models.dart';
import '../../../../blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';
import 'widgets/widgets.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late CarouselController carouselController;
  int currentArtistIndex = 1;

  @override
  void initState() {
    carouselController = CarouselController();
    updatePage();
    super.initState();
  }

  void setInitialIndexBySelectedArtist({
    required List<ArtistModel> allUserArtists,
    required ArtistModel selectedArtist,
  }) {
    for (var i = 0; i < allUserArtists.length; i++) {
      if (selectedArtist.id == allUserArtists[i].id) {
        currentArtistIndex = i;
      }
    }
  }

  List<Widget> buildArtistCards({
    required List<ArtistModel> allUserArtists,
    required ArtistModel selectedArtist,
  }) {
    List<Widget> result = [];
    for (var i = 0; i < allUserArtists.length + 1; i++) {
      if (i != allUserArtists.length) {
        result.add(
          ArtistCard(
            artist: allUserArtists[i],
            deletable: allUserArtists.length > 1,
            selected: selectedArtist.id == allUserArtists[i].id,
          ),
        );
      } else {
        result.add(const AddArtistCard());
      }
    }
    return result;
  }

  Future<void> updatePage() async {
    await Future.delayed(Duration.zero, () {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthStateAuthorized) {
        if (authState.user.isArtist == true) {
          context.read<UserArtistsBloc>().add(UserArtistsEventLoad(userId: authState.user.id));
          final userArtistsState = context.read<UserArtistsBloc>().state;
          if (userArtistsState is UserArtistsStateSelected) {
            setInitialIndexBySelectedArtist(
              allUserArtists: userArtistsState.allUserArtists,
              selectedArtist: userArtistsState.selectedArtist,
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: BlocBuilder<UserArtistsBloc, UserArtistsState>(
        builder: (context, state) {
          if (state is UserArtistsStateSelected) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: mediaQuery.padding.top + 24),
                PullPointAppBar(
                  title: "Ваши артисты",
                  onBackPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 24),
                CarouselSlider(
                  items: buildArtistCards(allUserArtists: state.allUserArtists, selectedArtist: state.selectedArtist),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    initialPage: currentArtistIndex,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() => currentArtistIndex = index);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < state.allUserArtists.length + 1; i++)
                    GestureDetector(
                      onTap: () => carouselController.animateToPage(i),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                              .withOpacity(currentArtistIndex == i ? 0.9 : 0.4),
                        ),
                      ),
                    ),
                ]
                    // state.allUserArtists.asMap().entries.map(
                    //   (entry) {
                    //     return
                    //   },
                    // ).toList(),
                    ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
