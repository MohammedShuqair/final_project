import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/CircleImage.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityCard extends StatelessWidget {
  static const String id = "/activityCard";
  final Activity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Core(
      padding: EdgeInsetsDirectional.only(
          start: 16.w, top: 19.h, bottom: 14.h, end: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleImage(
            imagePath: activity.user?.image ?? '',
          ),
          const SSizedBox(
            width: 9,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        activity.user?.name ?? '',
                        style: kStatusNumberTextStyle.copyWith(fontSize: 16.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 150.w),
                      child: Text(
                        activity.sendDate ?? '',
                        style: kSearchText,
                        textAlign: TextAlign.end,
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SSizedBox(
                  height: 4,
                ),
                Text(
                  activity.body ?? '',
                  style: textInTagTextStyle.copyWith(
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
