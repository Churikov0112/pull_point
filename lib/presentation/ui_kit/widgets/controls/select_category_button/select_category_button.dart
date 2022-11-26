import 'package:flutter/widgets.dart';

import '../../../ui_kit.dart';

class MainButton extends StatelessWidget {
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool disabled;
  final String childText;
  final Function()? onPressed;

  const MainButton({
    required this.childText,
    this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.disabled = false,
    this.disabledBackgroundColor = AppColors.icons,
    this.disabledTextColor = AppColors.text,
    this.textColor = AppColors.textOnColors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: borderColor ?? AppColors.orange, width: 1),
          color: disabled ? disabledBackgroundColor : backgroundColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: AppText(
              childText,
              textColor: disabled ? disabledTextColor : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
