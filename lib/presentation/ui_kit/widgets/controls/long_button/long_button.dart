import 'package:flutter/widgets.dart';
import '../../../ui_kit.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    required this.child,
    this.backgroundColor,
    this.isDisabled = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Function()? onTap;
  final Color? backgroundColor;
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
          color: isDisabled ? AppColors.primary.withOpacity(0.1) : backgroundColor,
        ),
        child: Center(child: child),
      ),
    );
  }
}
