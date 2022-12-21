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
                            onBackPressed: () {
                              Navigator.of(context).pop();
                            },
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
                          if (context.read<AuthBloc>().state is AuthStateGuest ||
                              context.read<AuthBloc>().state is AuthStateUnauthorized)
                            TouchableOpacity(
                              onPressed: () {
                                context.read<HomeBloc>().add(const HomeEventSelectTab(tabIndex: 4));
                                Navigator.of(context).pop();
                              },
                              child: CategoryChip(
                                backgroundColor: AppColors.backgroundPage.withOpacity(0.3),
                                textColor: AppColors.text,
                                childText: "Авторизуйтесь, чтобы добавлять в избранное",
                              ),
                            )
                          else if (getFavoritesState is GetFavoritesStatePending ||
                              addFavoritesState is AddFavoritesStatePending)
                            const CircularProgressIndicator(color: AppColors.orange)
                          else if (getFavoritesState is GetFavoritesStateLoaded &&
                              addFavoritesState is! AddFavoritesStatePending)
                            if (getFavoritesState.favorites?.contains(widget.artist) ?? false)
                              TouchableOpacity(
                                onPressed: () {},
                                child: CategoryChip(
                                  backgroundColor: AppColors.backgroundPage.withOpacity(0.3),
                                  textColor: AppColors.text,
                                  childText: "В избранном",
                                ),
                              )
                            else
                              TouchableOpacity(
                                onPressed: () {
                                  context
                                      .read<AddFavoritesBloc>()
                                      .add(AddFavoritesEventAdd(artistId: widget.artist.id));
                                },
                                child: CategoryChip(
                                  backgroundColor: AppColors.backgroundPage.withOpacity(0.1),
                                  textColor: AppColors.text,
                                  childText: "Добавить в избранное",
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
