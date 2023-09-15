import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/select_icon.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                const Spacer(),
                if (selectedCategories != null &&
                    selectedCategories!
                        .map((e) => e.id)
                        .toList()
                        .contains(categories[index].id)) ...[
                  const SelectIcon(),
                ],
                if (selectedCategory != null &&
                    selectedCategory!.id == categories[index].id) ...[
                  const SelectIcon(),
                ],
                const SSizedBox(
                  width: 10,
                ),
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
