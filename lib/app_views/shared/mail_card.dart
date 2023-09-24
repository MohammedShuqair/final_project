import "package:final_project/app_views/shared/custom_sized_box.dart";
import "package:final_project/app_views/shared/mail_image.dart";
import "package:final_project/core/util/constants.dart";
import "package:final_project/core/util/extensions.dart";
import "package:final_project/features/mail/models/mail.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "../../../core/util/colors.dart";
import "../../../core/util/styles.dart";

class MailCard extends StatelessWidget {
  const MailCard(
      {Key? key, required this.mail, required this.onTap, required this.index})
      : super(key: key);
  final Mail mail;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$index',
                    style: kSearchText.copyWith(
                        color: mail.status?.color == null
                            ? null
                            : Color(int.tryParse(
                                mail.status?.color ?? '0xFFB2B2B2')!)),
                  ),
                  const SSizedBox(
                    width: 2,
                  ),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: Color(
                          int.tryParse(mail.status?.color ?? "0xFFB2B2B2")!),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SSizedBox(
                    width: 11,
                  ),
                  Text(
                    mail.sender?.name?.firstCapital() ?? 'Name',
                    style: kTitleMailCard,
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        mail.archiveDate?.formatArriveTime() ?? '',
                        style: kSearchText,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: kSubText,
                      size: 19,
                    ),
                    const SSizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 24.w),
            child: Text(
              mail.subject ?? '',
              style: kSubTitleMailCard,
            ),
          ),
          if (mail.description?.isNotEmpty ?? false)
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 24.w, end: 10.w, bottom: 10.h, top: 8.h),
              child: Text(
                mail.description!,
                style:
                    kSubTitleMailCard.copyWith(color: const Color(0xff898989)),
              ),
            ),
          if (mail.tags != null)
            Padding(
              padding: EdgeInsetsDirectional.only(start: 24.w),
              child: Wrap(
                  spacing: 16,
                  children: mail.tags!
                      .map((e) => Text(
                            '# ${e.name?.firstCapital() ?? ''}',
                            style: kSelectedButton.copyWith(color: kLightSub),
                          ))
                      .toList()),
            ),
          const SSizedBox(
            height: 8,
          ),
          if (mail.attachments != null)
            Padding(
              padding: EdgeInsetsDirectional.only(start: 24.w),
              child: Wrap(
                  spacing: 16,
                  children: mail.attachments!
                      .map(
                        (e) => e.image == null || e.image!.isEmpty
                            ? const SizedBox()
                            : MailImage(
                                path: imageUrl + e.image!,
                              ),
                      )
                      .toList()),
            ),
        ],
      ),
    );
  }
}
