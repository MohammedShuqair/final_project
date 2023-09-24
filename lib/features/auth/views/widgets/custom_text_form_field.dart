import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
      this.autofillHints,
      this.onChanged,
      this.onTapOutside,
      this.focusNode,
      this.textInputAction});

  const CustomTextFormField.username({
    super.key,
    this.onChanged,
    this.hint = 'enter_username',
    this.password = false,
    this.keyboardType = TextInputType.name,
    this.validator,
    this.controller,
    this.autofillHints/*= const [AutofillHints.name]*/,
    this.onTapOutside,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
  });
  const CustomTextFormField.email({
    super.key,
    this.onChanged,
    this.hint = 'enter_email',
    this.password = false,
    this.keyboardType = TextInputType.emailAddress,
    this.validator,
    this.controller,
    this.autofillHints/*= const [AutofillHints.email]*/,
    this.onTapOutside,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
  });
  const CustomTextFormField.password({
    super.key,
    this.onChanged,
    this.hint = 'enter_password',
    this.password = true,
    this.keyboardType = TextInputType.visiblePassword,
    this.validator,
    this.controller,
    this.autofillHints/*= const [AutofillHints.password]*/,
    this.onTapOutside,
    this.focusNode,
    this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      focusNode: focusNode,
      onTapOutside: onTapOutside == null && focusNode != null
          ? (d) {
              focusNode!.unfocus();
            }
          : onTapOutside,
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
        hintText: hint != null ? context.tr(hint!) : hint,
        hintStyle: const TextStyle(fontSize: 12, color: kSubText),
        enabledBorder:
            const UnderlineInputBorder(borderSide: BorderSide(color: kBorder)),
        // border: Styles.primaryRoundedOutlineInputBorder,
        // focusedBorder: Styles.primaryRoundedOutlineInputBorder,
        // errorBorder: Styles.primaryRoundedOutlineInputBorder,
        // enabledBorder: Styles.primaryRoundedOutlineInputBorder,
        // disabledBorder: Styles.primaryRoundedOutlineInputBorder,
      ),
    );
  }
}
