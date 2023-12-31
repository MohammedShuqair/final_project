import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/search/provider/filter_provider.dart';
import 'package:final_project/app_views/search/provider/search_provider.dart';
import 'package:final_project/app_views/search/views/widgets/filter_bottom_sheet.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/shimmers/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  static const String id = '/searchView';

  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150.w,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 14.sp,
                  color: kDarkSub,
                ),
                Text(
                  "Home".tr(),
                  style: TextStyle(color: kLightSub, fontSize: 18.sp),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.h),
          child: Column(
            children: [
              Row(
                children: [
                  Consumer<SearchProvider>(
                    builder: (context, provider, child) {
                      return Expanded(
                        child: CustomSearchBar(
                          onSubmitted: (String value) {
                            if (value.isNotEmpty) {
                              provider
                                ..setSearchFor(value)
                                ..search();
                            }
                          },
                          onCancel: () {
                            provider.resetResponse();
                          },
                        ),
                      );
                    },
                  ),
                  const SSizedBox(width: 17),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet<Map>(
                            context: context,
                            isScrollControlled: true,
                            constraints:
                                BoxConstraints.tightFor(height: 1.sh - 60.h),
                            builder: (_) {
                              return ChangeNotifierProvider(
                                create: (BuildContext context2) =>
                                    FilterProvider(
                                  categories:
                                      context.read<SearchProvider>().categories,
                                  status: context.read<SearchProvider>().status,
                                  startDate:
                                      context.read<SearchProvider>().startDate,
                                  endDate:
                                      context.read<SearchProvider>().endDate,
                                ),
                                child: const FilterBottomSheet(),
                              );
                            }).then((map) {
                          if (map != null) {
                            context
                                .read<SearchProvider>()
                                .setStatusId(map['status_id']);
                            context
                                .read<SearchProvider>()
                                .setCategories(map['categories']);
                            context
                                .read<SearchProvider>()
                                .setEndDat(map['end']);
                            context
                                .read<SearchProvider>()
                                .setStartDat(map['start']);
                            context.read<SearchProvider>().search();
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: kLightSub,
                      ))
                ],
              ),
              const SSizedBox(
                height: 18,
              ),
              Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  return ResponseBuilder(
                    response: provider.searchResponse,
                    onComplete: (_, data, message, more) {
                      if (data.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: Text(
                            'No Mails Found'.tr(),
                            style: kLogo.copyWith(color: Colors.black),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          const SSizedBox(
                            height: 15,
                          ),
                          Text(
                            '${'Total'.tr()} ${data.values.toList().totalLength2D()}',
                            style: kSubTitleMailCard.copyWith(
                                color: kText,
                                decoration: TextDecoration.underline),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              String key = data.keys.elementAt(index);
                              List<Mail> mails = data[key] ?? [];

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        key.tr().firstCapital(),
                                        style: kTitleMailCard,
                                      ),
                                      Text(
                                        '${mails.length} ${'found'.tr()}',
                                        style: kSubTitleMailCard.copyWith(
                                            color: kSubText),
                                      ),
                                    ],
                                  ),
                                  const SSizedBox(
                                    height: 15,
                                  ),
                                  Core(
                                    child: Column(
                                      children: []..listMail(
                                          mails,
                                          (mail) => showMailDetailsSheet(
                                              context,
                                              mail,
                                              context
                                                  .read<SearchProvider>()
                                                  .search),
                                        ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SSizedBox(
                                height: 14,
                              );
                            },
                            itemCount: data.length,
                          ),
                        ],
                      );
                    },
                    onLoading: (_) {
                      List<String?> temp = defaultCategories
                          .map((e) => e.name)
                          .toList()
                        ..removeWhere(
                            (element) => element == null || element.isEmpty);
                      return ExpansionsShimmer(
                        titles: provider.categories.isNotEmpty
                            ? provider.categories.map((e) => e.name).toList()
                            : temp,
                      );
                    },
                    onError: (_, message) {
                      return Text('$message');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
