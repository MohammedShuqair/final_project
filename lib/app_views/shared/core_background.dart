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
      this.noShadow = false})
      : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool noShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height?.h,
      width: width?.w,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
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
