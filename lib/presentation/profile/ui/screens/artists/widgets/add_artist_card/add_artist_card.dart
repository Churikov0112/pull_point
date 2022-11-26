import 'package:flutter/material.dart';
import '../../../../../../ui_kit/ui_kit.dart';
import '../../add_artist_screen.dart';

class AddArtistCard extends StatelessWidget {
  const AddArtistCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return TouchableOpacity(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const AddArtistScreen(),
          ),
        );
      },
      child: Container(
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Center(
            child: AppText("Добавить артиста"),
          ),
        ),
      ),
    );
  }
}
