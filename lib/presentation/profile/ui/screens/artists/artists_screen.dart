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
      body: BlocListener<DeleteArtistBloc, DeleteArtistState>(
        listener: (context, deleteArtistListenerState) {
          if (deleteArtistListenerState is DeleteArtistStateDeleted) updatePage();
        },
        child: BlocListener<AddArtistBloc, AddArtistState>(
          listener: (context, addArtistState) {
            if (addArtistState is AddArtistStateCreated) updatePage();
          },
          child: BlocBuilder<DeleteArtistBloc, DeleteArtistState>(
            builder: (context, deleteArtistState) {
              if (deleteArtistState is DeleteArtistStateLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.orange));
              }
              return BlocBuilder<UserArtistsBloc, UserArtistsState>(
                builder: (context, userArtistsState) {
                  if (userArtistsState is UserArtistsStateSelected) {
                    return DecoratedBox(
                      decoration: const BoxDecoration(color: AppColors.backgroundPage),
                      child: Column(
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
                                allUserArtists: userArtistsState.allUserArtists,
                                selectedArtist: userArtistsState.selectedArtist),
                            currentIndex: currentArtistIndex,
                            carouselController: carouselController,
                            onPageChanged: (index, reason) {
                              setState(() => currentArtistIndex = index);
                            },
                          ),
                          const SizedBox(height: 12),
                          ArtistsDotIndicator(
                            length: userArtistsState.allUserArtists.length,
                            currentIndex: currentArtistIndex,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator(color: AppColors.orange));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
