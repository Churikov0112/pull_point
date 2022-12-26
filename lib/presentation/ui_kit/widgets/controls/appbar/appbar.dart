import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:pull_point/presentation/ui_kit/text/text.dart';
import '../touchable_opacity/touchable_opacity.dart';

class PullPointAppBar extends StatelessWidget {
  const PullPointAppBar({
    required this.title,
    this.titleMaxLines = 1,
    this.onBackPressed,
    this.right,
    super.key,
  });

  final String title;
  final int titleMaxLines;
  final Function()? onBackPressed;

  /// should be 32 px width
  final Widget? right;

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
              child:
                  const SizedBox.square(dimension: 24, child: Center(child: Icon(Icons.arrow_back_ios_new, size: 20))),
            ),
          const SizedBox(width: 16),
          SizedBox(
            width: mediaQuery.size.width - 128,
            child: AppTitle(
              // title,
              "titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle",
              maxLines: titleMaxLines,
            ),
          ),
          const Spacer(),
          if (right != null) right!,
          // GradientText(
          //   gradient: AppGradients.main,
          //   src: Text(
          //     title,
          //     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          //   ),
          // ),
        ],
      ),
    );
  }
}
