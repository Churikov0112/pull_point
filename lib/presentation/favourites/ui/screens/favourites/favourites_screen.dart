import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';
import 'package:pull_point/presentation/blocs/blocs.dart';

import '../../../../artist/artist_guest_screen.dart';
import '../../../../static_methods/firebase_methods.dart';
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
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await sendPushToMyself();
    // });
  }

  // Future<void> sendPushToMyself() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("UserTokens").doc("Egor").get();
  //   final token = snapshot["token"];

  //   await FirebaseStaticMethods.sendNotification(
  //     token,
  //     "Ваш любимый артист скоро начнет выступление",
  //     "Скорее бегите на улицу Ф. за шикарным представлением!",
  //   );
  // }

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
        child: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(
          builder: (context, getFavoritesState) {
            if (getFavoritesState is GetFavoritesStatePending) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.orange,
                ),
              );
            }

            if (context.read<AuthBloc>().state is AuthStateGuest) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppText(
                        "Чтобы добавлять артистов  в избранное, необходимо авторизоваться. Сделать это можно в профиле",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      LongButton(
                        backgroundColor: AppColors.orange,
                        onTap: () {
                          context.read<HomeBloc>().add(const HomeEventSelectTab(tabIndex: 4));
                        },
                        child: const AppText("В профиль", textColor: AppColors.textOnColors),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (getFavoritesState is GetFavoritesStateLoaded) {
              if (getFavoritesState.favorites.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: AppText(
                      "Тут пока пусто. Попробуйте добавить любимого артиста в избранное, и он окажется здесь",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: getFavoritesState.favorites.length,
                itemBuilder: (context, index) {
                  return ArtistItem(artist: getFavoritesState.favorites[index]);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
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
    return BlocListener<DeleteFavoritesBloc, DeleteFavoritesState>(
      listener: (context, deleteFavoritesListenerState) {
        if (deleteFavoritesListenerState is DeleteFavoritesStateReady) {
          context.read<GetFavoritesBloc>().add(const GetFavoritesEventGet(needUpdate: true));
        }
      },
      child: Padding(
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
                        BlocBuilder<DeleteFavoritesBloc, DeleteFavoritesState>(
                          builder: (context, deleteFavoritesState) {
                            if (deleteFavoritesState is DeleteFavoritesStatePending) {
                              if (deleteFavoritesState.artistId == artist.id) {
                                return const LoadingIndicator();
                              }
                            }
                            return TouchableOpacity(
                              onPressed: () {
                                context
                                    .read<DeleteFavoritesBloc>()
                                    .add(DeleteFavoritesEventDelete(artistId: artist.id));
                              },
                              child: const SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(
                                  Icons.favorite,
                                  color: AppColors.pink,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
