import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  const AppText(
    this.text, {
    this.textColor,
    this.backgroundColor,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        backgroundColor: backgroundColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
