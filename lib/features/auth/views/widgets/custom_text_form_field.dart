import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
      this.autofillHints,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      autofillHints: autofillHints,
      obscureText: password,
      enableSuggestions: password == true ? false : true,
      autocorrect: password == true ? false : true,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        hintText: hint,
        // border: Styles.primaryRoundedOutlineInputBorder,
        // focusedBorder: Styles.primaryRoundedOutlineInputBorder,
        // errorBorder: Styles.primaryRoundedOutlineInputBorder,
        // enabledBorder: Styles.primaryRoundedOutlineInputBorder,
        // disabledBorder: Styles.primaryRoundedOutlineInputBorder,
      ),
    );
  }
}
