import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/select_icon.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusList extends StatelessWidget {
  const StatusList({
    super.key,
    required this.statuses,
    required this.onTap,
    this.selectedStatus,
  });
  final Status? selectedStatus;
  final List<Status> statuses;
  final void Function(Status? id) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          if (statuses[index].name != null) {
            return InkWell(
              onTap: () => onTap(statuses[index]),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0.h),
                child: Row(
                  children: [
                    Container(
                      height: 34.h,
                      width: 34.w,
                      decoration: BoxDecoration(
                          color: Color(int.tryParse(
                              statuses[index].color ?? '0xFFE6E6E6')!),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SSizedBox(
                      width: 16,
                    ),
                    Text(
                      context.tr(statuses[index].name!.firstCapital()),
                      style: kSubTitleMailCard.copyWith(fontSize: 16.sp),
                    ),
                    const Spacer(),
                    if (selectedStatus != null &&
                        selectedStatus?.id == statuses[index].id) ...[
                      const SelectIcon()
                    ],
                    const SSizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SSizedBox();
          }
        },
        separatorBuilder: (_, index) {
          return const Divider();
        },
        itemCount: statuses.length);
  }
}
