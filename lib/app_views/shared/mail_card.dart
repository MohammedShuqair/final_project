import "package:final_project/app_views/home/views/widgets/chip_tag_widget.dart";
import "package:final_project/app_views/shared/alert.dart";
import "package:final_project/app_views/shared/core_background.dart";
import "package:final_project/app_views/shared/custom_sized_box.dart";
import "package:final_project/core/util/extensions.dart";
import "package:final_project/features/tag/models/tag.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../../core/util/colors.dart";
import "../../../core/util/styles.dart";

const String imageUrl = "https://palmail.gsgtt.tech/storage/";

class MailCard extends StatelessWidget {
  const MailCard(
      {Key? key,
      required this.organizationName,
      required this.lastDate,
      required this.subject,
      required this.body,
      required this.tags,
      required this.images,
      required this.status})
      : super(key: key);
  final String organizationName;
  final String lastDate;
  final String subject;
  final String body;
  final String status;
  final List<String> tags;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Row1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: Color(int.tryParse(status) ?? 0xFFB2B2B2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SSizedBox(
                  width: 11,
                ),
                Text(
                  organizationName.firstCapital(),
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
                      lastDate.formatArriveTime(),
                      style: kSearchText,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: kSubText,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            subject,
            style: kSubTitleMailCard,
          ),
        ),
        if (body.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: const EdgeInsets.only(left: 24),
            constraints: BoxConstraints(
              maxWidth: deviceSize.width * 0.7,
            ),
            child: Text(
              body,
              style: kSubTitleMailCard.copyWith(color: const Color(0xff898989)),
            ),
          ),
        const SSizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Wrap(
              spacing: 16,
              children: tags
                  .map((e) => Text(
                        '# ${e.firstCapital()}',
                        style: kSelectedButton.copyWith(color: kLightSub),
                      ))
                  .toList()),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Wrap(
              spacing: 16,
              children: images
                  .map(
                    (e) => Image.network(
                      imageUrl + e,
                      fit: BoxFit.fill,
                      width: 36.w,
                      height: 36.w,
                      errorBuilder: (_, e, ___) {
                        return SizedBox(
                          height: 36.w,
                          width: 36.w,
                          child: Placeholder(
                              child: Center(
                            child: Text(
                              'image error',
                              style: TextStyle(fontSize: 8.sp),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        );
                      },
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }
}
