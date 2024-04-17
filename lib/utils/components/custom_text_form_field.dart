import 'package:flutter/material.dart';

class CustomTextFormFieldAuth extends StatelessWidget {
  const CustomTextFormFieldAuth(
      {super.key,
      this.obscure,
      required this.hintText,
      required this.controller});
  final bool? obscure;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       decoration: InputDecoration(hintText: hintText),
      controller: controller,
      validator: (input) {
        if (controller.text.isEmpty) {
          return '$hintText must not be empty';
        } else {
          return null;
        }
      },
      obscureText: obscure ?? false,
    );
  }
}
