import 'package:flutter/material.dart';
import 'package:flutter_practice/shared/constants/styles.dart';

class CustomFormFields extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomFormFields({
    super.key,
    this.hintText,
    this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: kTextOutlineBorder,
        focusedBorder: kTextOutlineBorder,
        errorBorder: kTextOutlineErrorBorder,
        focusedErrorBorder: kTextOutlineErrorBorder,
      ),
    );
  }
}
