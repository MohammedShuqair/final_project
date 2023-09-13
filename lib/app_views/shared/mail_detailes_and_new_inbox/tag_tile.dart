import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TagTiles extends StatelessWidget {
  static const String id = "/tagTiles";
  final Set<Tag> tags;
  final void Function() onTap;

  const TagTiles({super.key, required this.tags, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Core(
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 18.w),
      child: InkWell(
        onTap: onTap,
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
                  tags.isEmpty
                      ? "Tags"
                      : tags
                          .map((e) => "#${e.name?.firstCapital()}")
                          .toList()
                          .join('  '),
                  style: tags.isEmpty
                      ? kHintNormal16Dark
                      : textInTagTextStyle.copyWith(color: kTag),
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
      ),
    );
  }
}
