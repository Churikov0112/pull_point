import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/profile/ui/screens/artists/widgets/artists_carousel/artists_carousel.dart';
import 'package:pull_point/presentation/profile/ui/screens/artists/widgets/artists_carousel/artists_dots_indicator.dart';

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
      body: BlocBuilder<DeleteArtistBloc, DeleteArtistState>(
        builder: ((context, deleteArtistState) {
          if (deleteArtistState is DeleteArtistStateDeleted) updatePage();

          return BlocBuilder<AddArtistBloc, AddArtistState>(
            builder: ((context, addArtistState) {
              if (addArtistState is AddArtistStateCreated) updatePage();

              return BlocBuilder<UserArtistsBloc, UserArtistsState>(
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
                        ArtistsCarousel(
                          items: buildArtistCards(
                              allUserArtists: state.allUserArtists, selectedArtist: state.selectedArtist),
                          currentIndex: currentArtistIndex,
                          carouselController: carouselController,
                          onPageChanged: (index, reason) {
                            setState(() => currentArtistIndex = index);
                          },
                        ),
                        const SizedBox(height: 12),
                        ArtistsDotIndicator(
                          length: state.allUserArtists.length,
                          currentIndex: currentArtistIndex,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }),
          );
        }),
      ),
    );
  }
}
