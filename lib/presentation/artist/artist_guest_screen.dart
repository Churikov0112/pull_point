import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/blocs/blocs.dart';
import 'package:pull_point/presentation/donation/donation_screen.dart';

import '../../domain/models/models.dart';
import '../ui_kit/ui_kit.dart';

class ArtistGuestScreen extends StatefulWidget {
  const ArtistGuestScreen({
    required this.artist,
    Key? key,
  }) : super(key: key);

  final ArtistModel artist;

  @override
  State<ArtistGuestScreen> createState() => _ArtistGuestScreenState();
}

class _ArtistGuestScreenState extends State<ArtistGuestScreen> {
  @override
  void initState() {
    context.read<GetFavoritesBloc>().add(const GetFavoritesEventGet(needUpdate: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocListener<AddFavoritesBloc, AddFavoritesState>(
      listener: (context, addFavoritesListenerState) {
        if (addFavoritesListenerState is AddFavoritesStateReady) {
          context.read<GetFavoritesBloc>().add(const GetFavoritesEventGet(needUpdate: true));
        }
      },
      child: BlocListener<DeleteFavoritesBloc, DeleteFavoritesState>(
        listener: (context, deleteFavoritesListenerState) {
          if (deleteFavoritesListenerState is DeleteFavoritesStateReady) {
            context.read<GetFavoritesBloc>().add(const GetFavoritesEventGet(needUpdate: true));
          }
        },
        child: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(
          builder: (context, getFavoritesState) {
            return BlocBuilder<AddFavoritesBloc, AddFavoritesState>(
              builder: (context, addFavoritesState) {
                return Scaffold(
                  backgroundColor: AppColors.backgroundCard,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: mediaQuery.padding.top + 24),
                            PullPointAppBar(
                              title: widget.artist.name ?? "Страница артиста",
                              titleMaxLines: 2,
                              onBackPressed: () {
                                Navigator.of(context).pop();
                              },
                              right: FavoritesButton(artist: widget.artist),
                            ),
                            const SizedBox(height: 32),
                            AppText(widget.artist.description ?? ""),
                            const SizedBox(height: 16),
                            const Divider(thickness: 1),
                            const SizedBox(height: 16),
                            if (widget.artist.category != null)
                              SizedBox(
                                width: mediaQuery.size.width,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    CategoryChip(
                                      gradient: AppGradients.main,
                                      childText: widget.artist.category!.name,
                                    ),
                                    if (widget.artist.subcategories != null)
                                      for (final subcategory in widget.artist.subcategories!)
                                        CategoryChip(
                                          gradient: AppGradients.first,
                                          childText: subcategory.name,
                                        ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 16),
                            const Divider(thickness: 1),
                            const SizedBox(height: 16),
                            const AppTitle("Последние выступления"),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: PPHistoryItem(),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LongButton(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => DonationScreen(artist: widget.artist),
                          ),
                        );
                      },
                      backgroundColor: AppColors.orange,
                      child: const AppText("Пожертвовать", textColor: AppColors.textOnColors),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FavoritesButton extends StatelessWidget {
  const FavoritesButton({
    required this.artist,
    super.key,
  });

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final getFavoritesState = context.read<GetFavoritesBloc>().state;

    if (authState is AuthStateGuest) {
      return GestureDetector(
        onTap: () {
          context.read<HomeBloc>().add(const HomeEventSelectTab(tabIndex: 4));
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.favorite_border_rounded,
          size: 32,
          color: AppColors.pink,
        ),
      );
    }

    if (getFavoritesState is GetFavoritesStatePending) {
      return const LoadingIndicator();
    }

    if (getFavoritesState is GetFavoritesStateLoaded) {
      if (getFavoritesState.favorites.contains(artist)) {
        return BlocBuilder<DeleteFavoritesBloc, DeleteFavoritesState>(
          builder: (context, deleteFavoritesState) {
            if (deleteFavoritesState is DeleteFavoritesStatePending) {
              return const LoadingIndicator();
            }
            return GestureDetector(
              onTap: () {
                context.read<DeleteFavoritesBloc>().add(DeleteFavoritesEventDelete(artist: artist));
              },
              child: const Icon(
                Icons.favorite,
                size: 32,
                color: AppColors.pink,
              ),
            );
          },
        );
      }
    }

    return BlocBuilder<AddFavoritesBloc, AddFavoritesState>(
      builder: (context, addFavoritesState) {
        if (addFavoritesState is AddFavoritesStatePending) {
          return const LoadingIndicator();
        }
        return GestureDetector(
          onTap: () {
            context.read<AddFavoritesBloc>().add(AddFavoritesEventAdd(artist: artist));
          },
          child: const Icon(
            Icons.favorite_border_rounded,
            size: 32,
            color: AppColors.pink,
          ),
        );
      },
    );
  }
}

class PPHistoryItem extends StatelessWidget {
  const PPHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: () {},
      child: Container(
        height: 120,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: AppColors.backgroundPage.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSubtitle(
                "Название выступления",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              const AppText(
                "Описание выступления Описание выступления Описание выступления Описание выступления Описание выступления",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              AppText(
                "23.12.2022",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textColor: AppColors.text.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
