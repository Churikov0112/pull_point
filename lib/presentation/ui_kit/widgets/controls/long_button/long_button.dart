import 'package:flutter/widgets.dart';
import '../../../ui_kit.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    required this.child,
    this.backgroundColor,
    this.backgroundGradient,
    this.isDisabled = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Function()? onTap;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return TouchableOpacity(
      onPressed: (onTap != null && !isDisabled) ? onTap : null,
      child: Container(
        height: 50,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: isDisabled
              ? LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary.withOpacity(0.1),
                  ],
                )
              : backgroundGradient,
          color: backgroundColor,
        ),
        child: Center(child: child),
      ),
    );
  }
}
