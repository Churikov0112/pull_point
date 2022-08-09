import 'package:flutter/material.dart';
import '../controls.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(text),
        ),
      ),
    );
  }
}
