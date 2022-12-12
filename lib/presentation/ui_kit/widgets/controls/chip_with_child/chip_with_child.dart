import 'package:flutter/widgets.dart';

import '../../../ui_kit.dart';

class ChipWithChild extends StatelessWidget {
  final Gradient? gradient;
  final Color? backgroundColor;
  final Widget child;

  const ChipWithChild({
    required this.child,
    this.gradient,
    this.backgroundColor,
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
        child: child,
      ),
    );
  }
}
