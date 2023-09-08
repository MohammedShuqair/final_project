import 'package:final_project/app_views/search/provider/search_provider.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/search/repo/search_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  static const String id = '/searchView';

  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? searchFor;

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
              Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  return CustomSearchBar(
                    onSubmitted: (String value) {
                      print(value);
                      provider.search(searchFor: value);
                    },
                    onCancel: () {
                      setState(() {
                        searchFor = null;
                      });
                    },
                  );
                },
              ),
              const SSizedBox(
                height: 18,
              ),
              Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  return ResponseBuilder(
                    response: provider.searchResponse,
                    onComplete: (_, data, message) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          String key = data.keys.elementAt(index);
                          List<Mail> mails = data[key] ?? [];
                          return ListView.separated(
                            itemBuilder: (_, index) => Column(
                              children: [],
                            ),
                            separatorBuilder: (_, index) => const SSizedBox(
                              height: 15,
                            ),
                            itemCount: mails.length,
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
