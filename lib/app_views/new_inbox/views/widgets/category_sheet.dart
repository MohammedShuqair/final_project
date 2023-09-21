import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/shared/category_list.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategorySheet extends StatefulWidget {
  const CategorySheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  late Category selected;
  @override
  void initState() {
    selected = context.read<NewInboxProvider>().selectedCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.0.h, bottom: 57.h),
            child: SheetBar(
                onTapDone: () {
                  context.read<NewInboxProvider>().setCategory(selected);

                  Navigator.pop(
                    context,
                  );
                },
                hint: 'Category'),
          ),
          Core(
            child: Consumer<NewInboxProvider>(
              builder: (context, provider, child) {
                return ResponseBuilder<List<Category>>(
                  response: provider.allCategoryResponse,
                  onComplete: (_, data, __, more) {
                    return CategoryList(
                      categories: data,
                      selectedCategory: selected,
                      onTap: (c) {
                        setState(() {
                          selected = c;
                        });
                        // Navigator.pop(context, c);
                      },
                    );
                  },
                  onError: (_, message) {
                    return Text(message ?? '');
                  },
                  onLoading: (_) {
                    return CustomShimmer(
                      highlightColor: kUnselect,
                      child: CategoryList(
                        categories: List.generate(
                            5,
                            (index) => Category(
                                    name: lorem(
                                  words: 1,
                                ))),
                        selectedCategories: [],
                        onTap: (Category c) {},
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
