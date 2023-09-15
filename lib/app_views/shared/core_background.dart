import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Core extends StatelessWidget {
  const Core(
      {Key? key,
      required this.child,
      this.margin,
      this.padding,
      this.width,
      this.height,
      this.noShadow = false,
      this.color,
      this.borderRadius})
      : super(key: key);
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final bool noShadow;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height?.h,
      width: width?.w,
      padding: padding ??
          EdgeInsetsDirectional.only(start: 16.w, top: 16.h, bottom: 16.h),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        boxShadow: noShadow
            ? null
            : const [
                BoxShadow(
                    color: Color(0xffEDECFC),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 5))
              ],
      ),
      child: child,
    );
  }
}
