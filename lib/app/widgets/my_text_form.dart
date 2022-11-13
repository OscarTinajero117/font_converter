import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final String labelTextDecoration;
  final String hintTextDecoration;
  final String? errorTextDecoration;
  final Widget? icon;
  final bool obscureText;
  final ValueChanged<String>? onFieldSubmitted;

  const MyTextForm({
    super.key,
    required this.controller,
    required this.labelTextDecoration,
    required this.hintTextDecoration,
    this.obscureText = false,
    this.maxLength = 10,
    this.maxLines = 1,
    this.keyboardType = TextInputType.multiline,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.errorTextDecoration,
    this.style,
    this.icon,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      style: style ??
          const TextStyle(
            fontSize: 15,
          ),
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelTextDecoration,
        hintText: hintTextDecoration,
        errorText: errorTextDecoration,
      ),
    );
  }
}
