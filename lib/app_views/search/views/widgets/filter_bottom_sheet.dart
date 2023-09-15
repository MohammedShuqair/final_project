import 'package:final_project/app_views/search/provider/filter_provider.dart';
import 'package:final_project/app_views/shared/category_list.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/app_views/shared/status_list.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        child: Column(
          children: [
            SheetBar(
              onTapDone: () {
                Navigator.pop(context, {
                  'categories': context.read<FilterProvider>().categories,
                  'status_id': context.read<FilterProvider>().status,
                  'end': null,
                  'start': null,
                });
              },
              hint: 'Filters',
            ),
            const SSizedBox(
              height: 57,
            ),
            Core(
              child: Selector<FilterProvider, ApiResponse<List<Category>>?>(
                selector: (context, provider) => provider.categoriesResponse,
                builder: (context, value, child) {
                  return ResponseBuilder(
                    response: value,
                    onComplete: (_, data, __) {
                      return Consumer<FilterProvider>(
                        builder: (context, provider, child) {
                          return CategoryList(
                            categories: data,
                            selectedCategories: provider.categories,
                            onTap: (Category category) {
                              provider.handelCategories(category);
                            },
                          );
                        },
                      );
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
                    onError: (_, message) {
                      return Text(message ?? '');
                    },
                  );
                },
              ),
            ),
            const SSizedBox(
              height: 16,
            ),
            Core(
              child: Selector<FilterProvider, ApiResponse<StatusResponse>?>(
                selector: (context, provider) => provider.statusResponse,
                builder: (context, value, child) {
                  return ResponseBuilder(
                    response: value,
                    onComplete: (_, data, __) {
                      return Consumer<FilterProvider>(
                        builder: (context, provider, child) {
                          return StatusList(
                            statuses: data.statuses ?? [],
                            selectedStatus: provider.status,
                            onTap: (Status? status) {
                              provider.handelStatus(status);
                            },
                          );
                        },
                      );
                    },
                    onLoading: (_) {
                      return CustomShimmer(
                        highlightColor: kUnselect,
                        child: StatusList(
                          statuses: List.generate(
                              4, (index) => Status(name: lorem(words: 1))),
                          selectedStatus: null,
                          onTap: (Status? s) {},
                        ),
                      );
                    },
                    onError: (_, message) {
                      return Text(message ?? '');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
