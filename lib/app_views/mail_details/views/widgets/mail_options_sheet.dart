import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MailOptionsSheet extends StatelessWidget {
  static const String id = '/mailOptions';
  const MailOptionsSheet(
      {super.key,
      required this.subject,
      required this.onTapArchive,
      required this.onTapShare,
      required this.onTapDelete});
  final String subject;
  final VoidCallback onTapArchive;
  final VoidCallback onTapShare;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w)
          .copyWith(bottom: 60.h, top: 19.h),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subject.firstCapital(),
              style: kTitleMailCard.copyWith(fontSize: 14.sp)),
          const SSizedBox(
            height: 34,
          ),
          Row(
            children: [
              Expanded(
                child: OptionButton(
                  iconPath: 'assets/icons/archive_option.svg',
                  title: context.tr('Archive'),
                  onTap: onTapArchive,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: OptionButton(
                  color: kLightSub,
                  iconPath: 'assets/icons/share.svg',
                  title: context.tr('Share'),
                  onTap: onTapShare,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: OptionButton(
                  color: kInbox,
                  iconPath: 'assets/icons/delete.svg',
                  title: context.tr('Delete'),
                  onTap: onTapDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.color,
  });
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 30.h, bottom: 19.h),
        decoration: const BoxDecoration(
            color: kWhite, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.0.w,
              height: 24.0.h,
            ),
            const SSizedBox(
              height: 12,
            ),
            Text(title, style: kF14N.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
