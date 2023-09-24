import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ArchiveWidget extends StatelessWidget {
  const ArchiveWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/archive.svg'),
        const SSizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('archive_number'),
                style: kHintNormal16Dark,
              ),
              AppTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.tr('Please_enter_archive_number.');
                  }
                  final regex = RegExp(r'^\d+/\d+$');
                  if (!regex.hasMatch(value)) {
                    return context.tr('Please_enter_valid_archive_number.');
                  }

                  return null;
                },
                controller: context.watch<NewInboxProvider>().archiveNumber,
                hintText: "like 1010/2023...",
                hintStyle: kSubTitleMailCard.copyWith(fontSize: 12.sp),
              )
            ],
          ),
        )
      ],
    );
  }
}
