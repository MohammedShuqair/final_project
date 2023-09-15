import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectIcon extends StatelessWidget {
  const SelectIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/selected.svg',
      width: 18.sp,
      height: 18.sp,
    );
  }
}
