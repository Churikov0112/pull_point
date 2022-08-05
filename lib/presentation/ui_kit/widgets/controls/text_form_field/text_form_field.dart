import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_point/presentation/ui_kit/colors/colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    this.controller,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.maxLines,
    this.autofocus,
    this.onEditingComplete,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? autofocus;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus ?? false,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
        filled: true,
        fillColor: AppColors.backgroundCard,
      ),
    );
  }
}
