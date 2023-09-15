import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.hintStyle,
    this.controller,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.focusNode,
    this.maxLines = 1,
  });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final void Function(String value)? onSubmitted;
  final String? Function(String? value)? validator;
  final bool enabled;
  final FocusNode? focusNode;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon2;
    if (suffixIcon != null) {
      suffixIcon2 = Padding(
        padding: EdgeInsetsDirectional.only(end: 15.w),
        child: suffixIcon,
      );
    }
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onTapOutside: (s) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            maxLines: maxLines,
            focusNode: focusNode,
            enabled: enabled,
            onFieldSubmitted: onSubmitted,
            validator: validator,
            style: hintStyle != null
                ? hintStyle!.copyWith(color: Colors.black)
                : kHintSimi16AF.copyWith(color: Colors.black),
            controller: controller,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: hintStyle ?? kHintSimi16AF,
              hintText: hintText,
              prefixIconConstraints: prefixIcon != null
                  ? BoxConstraints.tightFor(width: 24.w + 6.w, height: 24.h)
                  : BoxConstraints.tight(const Size(0, 0)),
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: 6.w),
                child: prefixIcon,
              ),
            ),
          ),
        ),
        suffixIcon2 ?? const SizedBox(),
      ],
    );
  }
}
