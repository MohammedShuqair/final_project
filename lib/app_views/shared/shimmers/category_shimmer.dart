import 'package:final_project/app_views/shared/category_list.dart';
import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:flutter/material.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      highlightColor: kUnselect,
      child: CategoryList(
        categories: List.generate(defaultCategories.length,
            (index) => Category(name: defaultCategories[index].name!)),
        selectedCategories: const [],
        onTap: (Category c) {},
      ),
    );
  }
}
