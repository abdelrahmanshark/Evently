import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

typedef OnValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final OnValidator? onValidator;
  final EdgeInsetsGeometry? padding;
  final TextStyle? errorStyle;
  final Color? outLineBorderColor;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? obscureChar;
  void Function(String)? onChange;

  CustomTextFormField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPrefixIcon = true,
    this.hasSuffixIcon = false,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onValidator,
    this.errorStyle,
    this.outLineBorderColor,
    this.controller,
    this.obscureText = false,
    this.obscureChar,
    this.padding,
    this.maxLines,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme;
    return TextFormField(
      maxLines: maxLines,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        contentPadding: padding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: outLineBorderColor ?? theme.disabledColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: outLineBorderColor ?? theme.disabledColor,
            width: 2,
          ),
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? textStyle.labelSmall,
        prefixIcon: hasPrefixIcon
            ? Icon(prefixIcon, color: prefixIconColor ?? theme.disabledColor)
            : null,
        suffixIcon: hasSuffixIcon
            ? Icon(suffixIcon, color: suffixIconColor ?? theme.disabledColor)
            : null,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: errorStyle ?? TextStyle(fontSize: 16, color: Colors.red),
      ),
      style: textStyle.bodyLarge,
      validator: onValidator,
      controller: controller,
      obscureText: obscureText!,
      obscuringCharacter: obscureChar ?? '.',
      cursorColor: AppColors.primaryColor,
      onChanged: onChange,
    );
  }
}
