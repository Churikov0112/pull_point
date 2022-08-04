import 'package:flutter/widgets.dart';

import '../../../ui_kit.dart';

class CategoryChip extends StatelessWidget {
  final Gradient gradient;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? textColor;
  final bool disabled;
  final String childText;

  const CategoryChip({
    required this.gradient,
    required this.childText,
    this.disabled = false,
    this.disabledBackgroundColor = AppColors.icons,
    this.disabledTextColor = AppColors.text,
    this.textColor = AppColors.textOnColors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        gradient: !disabled ? gradient : null,
        color: disabled ? disabledBackgroundColor : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: AppButtonText(childText, textColor: disabled ? disabledTextColor : textColor),
      ),
    );
  }
}
