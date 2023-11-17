

import 'package:flutter/material.dart';

import '../service/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? helperText;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final VoidCallback? onPressed;
  final void Function(String)? onSubmitted;
  final String hintText;
  final bool readOnly;
  final bool obscureText;
  final int? maxLine;
  final bool? isValid;

  const CustomTextField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.onPressed,
    this.readOnly = false,
    required this.hintText,
    this.onSubmitted,
    this.suffix,
    this.obscureText = false,
    this.maxLine,
    this.helperText,
    this.onChanged,
    this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      maxLines: maxLine,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      readOnly: readOnly,
      controller: controller,
      onTap: onPressed,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: isValid != null
              ? BorderSide(color: isValid! ? KTColors.orange : Colors.red)
              : const BorderSide(color: KTColors.orange),
        ),
        helperText: helperText,
        helperStyle: const TextStyle(color: Colors.red),
        prefixIcon: prefixIcon,
        suffixIcon: suffix,
        fillColor: Colors.white10,
        hintText: hintText,
        filled: true,
      ),
    );
  }
}