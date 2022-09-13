import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../../colors/app_gradients.dart';
import '../../containers/gradient_text/gradient_text.dart';
import '../touchable_opacity/touchable_opacity.dart';

class PullPointAppBar extends StatelessWidget {
  const PullPointAppBar({
    required this.title,
    this.onBackPressed,
    super.key,
  });

  final String title;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      width: mediaQuery.size.width - 32,
      child: Row(
        children: [
          if (onBackPressed != null)
            TouchableOpacity(
              onPressed: () {
                onBackPressed?.call();
                // Navigator.of(context).pop();
              },
              child: const SizedBox.square(dimension: 24, child: Center(child: Icon(Icons.arrow_back_ios_new, size: 20))),
            ),
          const SizedBox(width: 8),
          GradientText(
            gradient: AppGradients.main,
            src: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
