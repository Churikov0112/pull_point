import 'package:flutter/widgets.dart';

import '../../../ui_kit.dart';

class CategoryChip extends StatelessWidget {
  final Gradient? gradient;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? textColor;
  final Color? backgroundColor;
  final bool disabled;
  final String childText;

  const CategoryChip({
    required this.childText,
    this.gradient,
    this.backgroundColor,
    this.disabled = false,
    this.disabledBackgroundColor = AppColors.icons,
    this.disabledTextColor = AppColors.text,
    this.textColor = AppColors.textOnColors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: !disabled ? gradient : null,
          color: disabled ? disabledBackgroundColor : backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: AppButtonText(childText, textColor: disabled ? disabledTextColor : textColor),
        ),
      ),
    );
  }
}
