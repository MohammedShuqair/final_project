import 'package:final_project/app_views/new_inbox/views/widgets/sender_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.hintStyle,
  });
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon2;
    if (suffixIcon != null) {
      suffixIcon2 = Padding(
        padding: EdgeInsetsDirectional.only(end: 15.w),
        child: suffixIcon,
      );
    }
    return TextField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide
              .none /*(
            color: Color(0xFFD0D0D0),
          )*/
          ,
        ),
        /*focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD0D0D0),
          ),
        ),*/
        hintStyle: hintStyle ?? kHintSimi16AF,
        hintText: hintText,
        prefixIconConstraints: prefixIcon != null
            ? BoxConstraints.tightFor(width: 24.w + 6.w, height: 24.h)
            : BoxConstraints.tight(const Size(0, 0)),
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end: 6.w),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon2,
      ),
    );
  }
}
