import 'package:flutter/material.dart' show Brightness, Colors, Theme;
import 'package:flutter/widgets.dart';

class ArtistsDotIndicator extends StatelessWidget {
  const ArtistsDotIndicator({
    required this.length,
    required this.currentIndex,
    this.onTap,
    super.key,
  });

  final int length;
  final Function()? onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < length + 1; i++)
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                    .withOpacity(currentIndex == i ? 0.9 : 0.4),
              ),
            ),
          ),
      ],
    );
  }
}
