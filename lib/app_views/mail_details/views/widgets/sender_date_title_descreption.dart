import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SenderDataTitleDescription extends StatefulWidget {
  const SenderDataTitleDescription(
      {super.key,
      required this.senderName,
      required this.categoryName,
      required this.date,
      required this.archiveNumber,
      required this.title,
      required this.description});
  final String senderName;
  final String categoryName;
  final String date;
  final String archiveNumber;
  final String title;
  final String? description;

  @override
  State<SenderDataTitleDescription> createState() =>
      _SenderDataTitleDescriptionState();
}

class _SenderDataTitleDescriptionState
    extends State<SenderDataTitleDescription> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Core(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        width: 16.0.w,
                        height: 15.0.h,
                      ),
                      const SSizedBox(
                        width: 6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.senderName,
                              style: kStatusName16RegDark.copyWith(
                                  fontWeight: FontWeight.w600)),
                          const SSizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.categoryName,
                            style: kSearchText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.date,
                        style:
                            kSearchText.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('Arch ${widget.archiveNumber}', style: kSearchText),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: kLine),
          const SSizedBox(
            height: 4,
          ),
          if (widget.description != null && widget.description!.isNotEmpty) ...[
            ExpansionTile(
              tilePadding: EdgeInsetsDirectional.only(end: 19.w),
              shape: LinearBorder.none,
              title: Text(
                widget.title,
                style: kStatusNumberTextStyle,
              ),
              onExpansionChanged: (bool opened) => setState(
                () {
                  open = opened;
                },
              ),
              trailing: open
                  ? const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: kLightSub,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_right,
                      color: kSubText,
                    ),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.description!,
                        style: kSubTitleMailCard.copyWith(color: kText2),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ] else ...[
            Text(
              widget.title,
              style: kStatusNumberTextStyle,
            )
          ]
        ],
      ),
    );
  }
}
