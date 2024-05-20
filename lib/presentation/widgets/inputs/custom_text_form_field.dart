import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;

  const CustomTextFormField(
      {super.key,
      this.obscureText = false,
      this.label,
      this.hint,
      this.errorMessage,
      this.onChanged,
      this.validator,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      // borderSide: BorderSide(color: colors.primary,)
    );
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder:
              border.copyWith(borderSide: BorderSide(color: colors.primary)),
          errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red.shade800)),
          isDense: true,
          label: label != null
              ? Text(label!)
              : null, // Texto que identifica el campo
          hintText: hint, // PlaceHolder
          errorText: errorMessage,
          focusColor: colors.primary,
          prefixIcon: prefixIcon),
    );
  }
}
