import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../ui_kit/ui_kit.dart';
import '../../artists/artists_screen.dart';

class ArtistInfoWidget extends StatelessWidget {
  const ArtistInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: BlocBuilder<UserArtistsBloc, UserArtistsState>(
        builder: (context, state) {
          if (state is UserArtistsStateSelected) {
            return TouchableOpacity(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ArtistsScreen(),
                  ),
                );
              },
              child: Container(
                width: mediaQuery.size.width,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText("Артист"),
                      // AppText("id: ${state.selectedArtist.id}"),
                      const SizedBox(height: 8),
                      AppTitle(state.selectedArtist.name ?? "-"),
                      const SizedBox(height: 8),
                      AppText(state.selectedArtist.description ?? "-"),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: mediaQuery.size.width,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (state.selectedArtist.category != null)
                              StaticChip(
                                gradient: AppGradients.main,
                                childText: state.selectedArtist.category!.name,
                              ),
                            if (state.selectedArtist.subcategories != null)
                              for (final subcategory in state.selectedArtist.subcategories!)
                                StaticChip(
                                  gradient: AppGradients.first,
                                  childText: subcategory.name,
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is UserArtistsStateLoading) {
            return Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: AppColors.backgroundCard,
              ),
              child: const Center(child: CircularProgressIndicator(color: AppColors.orange)),
            );
          }

          return Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: AppColors.backgroundCard,
            ),
            child: const Center(child: CircularProgressIndicator(color: AppColors.orange)),
          );
        },
      ),
    );
  }
}
