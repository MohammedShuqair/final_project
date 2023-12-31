import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InBoxButton extends StatelessWidget {
  const InBoxButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color(0xffEDECFC),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 0))
      ]),
      padding: EdgeInsets.symmetric(
        vertical: 16.0.h,
        horizontal: 20.w,
      ),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: const BoxDecoration(
              color: kLightSub,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              weight: 600,
            ),
          ),
          const SSizedBox(
            width: 16,
          ),
          Text(
            context.tr("new_inbox"),
            style: kInBoxButtonTextStyle,
          ),
        ],
      ),
    );
  }
}
