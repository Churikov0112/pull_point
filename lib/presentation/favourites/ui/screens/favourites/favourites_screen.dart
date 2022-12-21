import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';
import 'package:pull_point/presentation/blocs/blocs.dart';

import '../../../../artist/artist_guest_screen.dart';
import '../../../../ui_kit/ui_kit.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    context.read<GetFavoritesBloc>().add(const GetFavoritesEventGet(needUpdate: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100,
      color: AppColors.orange,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        context.read<GetFavoritesBloc>().add(const GetFavoritesEventGet(needUpdate: true));
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.backgroundPage,
        ),
        child: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(builder: (context, getFavoritesState) {
          if (getFavoritesState is GetFavoritesStatePending) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.orange,
              ),
            );
          }

          if (getFavoritesState is GetFavoritesStateLoaded) {
            if (getFavoritesState.favorites != null) {
              return ListView.builder(
                itemCount: getFavoritesState.favorites!.length,
                itemBuilder: (context, index) {
                  return ArtistItem(artist: getFavoritesState.favorites![index]);
                },
              );
            }
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

class ArtistItem extends StatelessWidget {
  const ArtistItem({
    required this.artist,
    super.key,
  });

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TouchableOpacity(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ArtistGuestScreen(artist: artist),
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitle(artist.name ?? "null name"),
                const SizedBox(height: 8),
                AppText(artist.description ?? "null description"),
                const SizedBox(height: 16),
                SizedBox(
                  width: mediaQuery.size.width,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (artist.category != null)
                        StaticChip(
                          gradient: AppGradients.main,
                          childText: artist.category!.name,
                        ),
                      if (artist.subcategories != null)
                        for (final subcategory in artist.subcategories!)
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
      ),
    );
  }
}
