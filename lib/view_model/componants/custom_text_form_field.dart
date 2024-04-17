import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.onTap,
    this.onChanged,
    this.validator,
    this.obscure,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscure;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 60,
        width: double.maxFinite,
        child: TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   borderSide: BorderSide(color: Colors.blue.withOpacity(.5)),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   borderSide: BorderSide(color: Colors.blue.withOpacity(.5)),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   borderSide: BorderSide(color: Colors.blue.withOpacity(.5)),
            // ),
            hintText: hintText,
          ),
          obscureText: obscure ?? false,
        ),
      ),
    );
  }
}
