import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_tile_item.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/status/models/status.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    super.key,
    required this.selectedStatus,
  });
  final Status? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return FormField<Status?>(validator: (status) {
      if (selectedStatus == null) {
        return context.tr('Please Select Status');
      }
      return null;
    }, builder: (FormFieldState state) {
      return Core(
        padding: EdgeInsets.symmetric(
            horizontal: 17.w, vertical: selectedStatus == null ? 18.h : 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    context.tr("status"),
                    style: kHintNormal16Dark,
                  ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/arrow_gray.svg',
                  width: 18.0,
                  height: 12.0,
                ),
              ],
            ),
            const SSizedBox(
              height: 2,
            ),
            if (state.hasError && state.errorText != null) ...{
              Padding(
                padding: EdgeInsetsDirectional.only(top: 10.h, start: 28.w),
                child: Text(
                  state.errorText!,
                  style: kSearchText.copyWith(
                      color: Theme.of(context).colorScheme.error),
                ),
              ),
            }
          ],
        ),
      );
    });
  }
}
