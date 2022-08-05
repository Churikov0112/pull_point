import 'package:flutter/widgets.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    required this.gradient,
    required this.src,
    Key? key,
  }) : super(key: key);

  final Gradient gradient;
  final Widget src;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: src,
    );
  }
}
