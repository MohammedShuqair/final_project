import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/search/provider/filter_provider.dart';
import 'package:final_project/app_views/shared/category_list.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/date_picker.dart';
import 'package:final_project/app_views/shared/shimmers/category_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/app_views/shared/shimmers/status_list_shimmer.dart';
import 'package:final_project/app_views/shared/status_list.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:flutter/material.dart';
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
                  'end': context.read<FilterProvider>().endDate,
                  'start': context.read<FilterProvider>().startDate,
                });
              },
              hint: 'filters'.tr(),
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
                    onComplete: (_, data, __, more) {
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
                      return const CategoryShimmer();
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
                    onComplete: (_, data, __, more) {
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
                    onLoading: (_) => const StatusListShimmer(),
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
              child: Consumer<FilterProvider>(
                builder: (context, provider, child) {
                  return CustomDatePicker(
                    hint: "From Date".tr(),
                    selectedDate: provider.startDate,
                    onChangeDate: (DateTime newDate) {
                      provider.setStartDat(newDate);
                    },
                  );
                },
              ),
            ),
            const SSizedBox(
              height: 8,
            ),
            Core(
              child: Consumer<FilterProvider>(
                builder: (context, provider, child) {
                  return CustomDatePicker(
                    hint: "To Date".tr(),
                    selectedDate: provider.endDate,
                    onChangeDate: (DateTime newDate) {
                      provider.setEndDat(newDate);
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
