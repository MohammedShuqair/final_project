import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_tile_item.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/status/models/status.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({super.key, required this.selectedStatus});
  final Status? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Core(
      padding: EdgeInsets.symmetric(
          horizontal: 17.w, vertical: selectedStatus == null ? 18.h : 12.h),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/indox.svg',
            width: 19.0.w,
            height: 14.0.h,
          ),
          const SSizedBox(
            width: 10,
          ),
          if (selectedStatus != null)
            StatusTileItem(
              status: selectedStatus!,
            ),
          if (selectedStatus == null)
            Text(
              "Status",
              style: kHintNormal16Dark,
            ),
          Spacer(),
          SvgPicture.asset(
            'assets/icons/arrow_gray.svg',
            width: 18.0,
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
