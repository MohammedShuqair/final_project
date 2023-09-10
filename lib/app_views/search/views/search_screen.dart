import 'package:final_project/app_views/search/provider/filter_provider.dart';
import 'package:final_project/app_views/search/provider/search_provider.dart';
import 'package:final_project/app_views/search/views/widgets/filter_bottom_sheet.dart';
import 'package:final_project/app_views/shared/category_list.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/app_views/shared/status_list.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
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
                  Icons.arrow_back_ios_new,
                  size: 14.sp,
                  color: kDarkSub,
                ),
                Text(
                  "Home",
                  style: TextStyle(color: kLightSub, fontSize: 18.sp),
                )
              ],
            ),
          ),
        ),
        actions: [],
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
                            print(value);
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
                                  categoryNames: context
                                      .read<SearchProvider>()
                                      .categoryNames,
                                  statusId:
                                      context.read<SearchProvider>().statusId,
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
                    onComplete: (_, data, message) {
                      print(data);
                      if (data.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: Text(
                            'No Mails Found',
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
                            'Total ${data.values.toList().totalLength2D()} Found',
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
                                        key.firstCapital(),
                                        style: kTitleMailCard,
                                      ),
                                      Text(
                                        '${mails.length} Found',
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
                                      children: []..listMail(mails),
                                    ),
                                  ),
                                ],
                              );
                              // return ExpansionWidget(
                              //   title: key,
                              //   count: mails.length,
                              //   mails: mails,
                              // );
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
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return CustomShimmer(
                            highlightColor: Colors.black,
                            child: ExpansionWidget(
                              title: lorem(words: 1),
                              count: 0,
                              mails: const [],
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const SSizedBox(
                            height: 14,
                          );
                        },
                        itemCount: 3,
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
