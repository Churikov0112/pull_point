import 'package:flutter/widgets.dart';

import '../../../ui_kit.dart';

class StaticChip extends StatelessWidget {
  final Gradient? gradient;
  final Color? textColor;
  final Color? backgroundColor;
  final String childText;

  const StaticChip({
    required this.childText,
    this.gradient,
    this.backgroundColor,
    this.textColor = AppColors.textOnColors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        gradient: gradient,
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: AppButtonText(childText, textColor: textColor),
      ),
    );
  }
}
