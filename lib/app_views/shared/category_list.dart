import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categories,
    required this.onTap,
    required this.selectedNames,
  });
  final List<String> selectedNames;
  final List<Category> categories;
  final void Function(String name) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          if (categories[index].name != null) {
            return InkWell(
              onTap: () => onTap(categories[index].name!),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0.h),
                child: Row(
                  children: [
                    Text(
                      categories[index].name!.firstCapital(),
                      style: kSubTitleMailCard.copyWith(fontSize: 16.sp),
                    ),
                    Spacer(),
                    if (selectedNames.contains(categories[index].name)) ...[
                      Icon(
                        Icons.check,
                        size: 18.sp,
                        color: kLightSub,
                      )
                    ]
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
        itemCount: categories.length);
  }
}
