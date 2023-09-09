import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagTiles extends StatefulWidget {
  static const String id = "/tagTiles";

  const TagTiles({super.key});

  @override
  State<TagTiles> createState() => _TagTilesState();
}

class _TagTilesState extends State<TagTiles> {
  List<String> tags = [
    'Urgent',
    'Egyptian Military',
    'Egyptian Military',
    'Egyptian Military',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 56,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/hashtag.svg',
            width: 12.0.w,
            height: 27.0.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 18.w, end: 10.w),
              child: Text(
                tags.map((e) => "#${e.firstCapital()}").toList().join('  '),
                style: textInTagTextStyle.copyWith(color: kTag),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
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
