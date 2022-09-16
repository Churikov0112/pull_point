import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../domain/models/models.dart';
import '../../../../../../blocs/blocs.dart';
import '../../../../../../ui_kit/ui_kit.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    required this.artist,
    required this.selected,
    required this.deletable,
    super.key,
  });

  final ArtistModel artist;
  final bool selected;
  final bool deletable;

  showDeleteArtistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Удалить артиста ${artist.name}?"),
          actions: [
            TextButton(
              child: const Text("Отмена"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(overlayColor: MaterialStateProperty.all(AppColors.error.withOpacity(0.1))),
              onPressed: () {
                context.read<DeleteArtistBloc>().add(DeleteArtistEventDelete(artistId: artist.id));
                Navigator.of(context).pop();
              },
              child: const AppText(
                "Удалить",
                textColor: AppColors.error,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      decoration: const BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitle(artist.name ?? "-"),
                const SizedBox(height: 8),
                AppText(artist.description ?? "-"),
              ],
            ),
            if (deletable)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(AppColors.error.withOpacity(0.1)),
                    ),
                    onPressed: () {
                      showDeleteArtistDialog(context);
                    },
                    child: const AppText(
                      "Удалить",
                      textColor: AppColors.error,
                    ),
                  ),
                  if (!selected)
                    TextButton(
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthStateAuthorized) {
                          context.read<UserArtistsBloc>().add(UserArtistsEventSelect(artistId: artist.id, userId: authState.user.id));
                        }
                      },
                      child: const AppText("Выбрать"),
                    ),
                  if (selected)
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: AppText(
                        "Выбрано",
                        textColor: AppColors.success,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
