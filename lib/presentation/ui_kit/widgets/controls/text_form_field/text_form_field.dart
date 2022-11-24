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
    this.onEditingComplete,
    this.onChanged,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  final TextInputType? keyboardType;
  final int? maxLines;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        contentPadding: const EdgeInsets.only(left: 16),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(color: AppColors.orange),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(color: AppColors.orange),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          borderSide: BorderSide(color: AppColors.orange),
        ),
        filled: true,
        fillColor: AppColors.backgroundCard,
      ),
    );
  }
}
