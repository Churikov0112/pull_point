import 'package:flutter/material.dart';

import '../../../../../../../domain/models/models.dart';
import '../../../../../../ui_kit/ui_kit.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    required this.artist,
    super.key,
  });

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return TouchableOpacity(
      onPressed: () {},
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
              const SizedBox(height: 8),
              AppTitle(artist.name ?? "-"),
              const SizedBox(height: 8),
              AppText(artist.description ?? "-"),
            ],
          ),
        ),
      ),
    );
  }
}
