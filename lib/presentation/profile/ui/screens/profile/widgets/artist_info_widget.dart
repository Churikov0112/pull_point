import 'package:flutter/material.dart';
import '../../../../../ui_kit/ui_kit.dart';
import '../../artists/artists_screen.dart';

class ArtistInfoWidget extends StatelessWidget {
  const ArtistInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
            children: const [
              AppText("Артист"),
              SizedBox(height: 8),
              AppTitle("dummy artist loooooooooooooong name"),
            ],
          ),
        ),
      ),
    );
  }
}
