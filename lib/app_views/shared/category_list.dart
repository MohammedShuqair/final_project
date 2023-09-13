import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categories,
    required this.onTap,
    this.selectedCategories,
    this.selectedCategory,
  });
  final List<Category>? selectedCategories;
  final Category? selectedCategory;
  final List<Category> categories;
  final void Function(Category category) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => onTap(categories[index]),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0.h),
              child: Row(children: [
                Text(
                  categories[index].name!.firstCapital(),
                  style: kSubTitleMailCard.copyWith(fontSize: 16.sp),
                ),
                Spacer(),
                if (selectedCategories != null &&
                    selectedCategories!
                        .map((e) => e.id)
                        .toList()
                        .contains(categories[index].id)) ...[
                  Icon(
                    Icons.check,
                    size: 18.sp,
                    color: kLightSub,
                  ),
                ],
                if (selectedCategory != null &&
                    selectedCategory!.id == categories[index].id) ...[
                  SvgPicture.asset(
                    'assets/icons/selected.svg',
                    width: 18.sp,
                    height: 18.sp,
                  ),
                  SSizedBox(
                    width: 10,
                  ),
                ],
              ]),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return const Divider();
        },
        itemCount: categories.length);
  }
}
