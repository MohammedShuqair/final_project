import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/widgets/status_grid_view.dart';
import 'package:final_project/app_views/home/views/widgets/tags_widget.dart';
import 'package:final_project/app_views/search/views/search_screen.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/features/auth/views/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../shared/expansion_tile.dart';

class HomeView extends StatelessWidget {
  static const String id = '/homeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchView.id);
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<dynamic>>[
                PopupMenuItem(
                  child: Container(
                    height: 200,
                    width: 500,
                    color: Colors.grey,
                  ),
                ),
              ];
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(end: 33.w),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kWhite,
                    width: 3,
                  )),
              child: Image.asset(
                'assets/images/palestine_bird.png',
                fit: BoxFit.contain,
                width: 40.w,
                height: 40.w,
              ),
            ),
          ),
          /*   IconButton(
              onPressed: () async {
                MailRepository().updateMail(
                  mailId: 31,
                  statusId: "4",
                  decision: "",
                  finalDecision: "",
                  activities: [],
                  tags: [],
                  idAttachmentsForDelete: [],
                  pathAttachmentsForDelete: [],
                );
              },
              icon: Icon(Icons.refresh)),*/
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            SizedBox(
              height: 500,
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await context.read<HomeProvider>().getAllTags();
          await context.read<HomeProvider>().getAllStatus(false);
          await context.read<HomeProvider>().getAllMailsByCategories();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const StatusGridView(),
                const SSizedBox(
                  height: 14,
                ),
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return ResponseBuilder(
                      response: provider.allMailsResponse,
                      onComplete: (_, data, message) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            String key = data.keys.elementAt(index);
                            List<Mail> mails = data[key] ?? [];
                            return ExpansionWidget(
                              title: key,
                              count: mails.length,
                              mails: mails,
                            );
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
                          itemCount: 2,
                        );
                      },
                      onError: (_, message) {
                        return Text('$message');
                      },
                    );
                  },
                ),
                const SSizedBox(
                  height: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 16),
                      child: Text(
                        "Tags",
                        style: tagTitleTextStyle,
                      ),
                    ),
                    const SSizedBox(
                      height: 16,
                    ),
                    const Tags(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context, UserProvider provider) async {
    await provider.logout();
    handelResponseStatus(
      provider.currentUserResponse.status,
      context,
      message: provider.currentUserResponse.message,
      onComplete: () {
        Navigator.pushNamedAndRemoveUntil(
            context, SplashView.id, (route) => false);
      },
    );
  }
}
