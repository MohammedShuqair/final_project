import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagTiles extends StatelessWidget {
  static const String id = "/tagTiles";
  final Set<Tag> tags;
  final void Function()? onTap;

  const TagTiles({super.key, required this.tags, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Core(
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 18.w),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Text(
              '#',
              style: TextStyle(color: kText),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
                child: Text(
                  tags.isEmpty
                      ? context.tr("tags")
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
            const Icon(
              Icons.arrow_forward_ios,
              color: kSubText,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}
