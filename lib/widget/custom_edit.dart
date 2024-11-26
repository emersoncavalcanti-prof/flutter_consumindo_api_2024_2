// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomEdit extends StatelessWidget {
  final String label;
  final Icon icone;
  final bool isObscure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomEdit({
    super.key,
    required this.label,
    required this.icone,
    this.validator,
    this.controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObscure,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: icone,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
