import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/widgets/new_inbox_btn.dart';
import 'package:final_project/app_views/home/views/widgets/status_grid_view.dart';
import 'package:final_project/app_views/home/views/widgets/tags_widget.dart';
import 'package:final_project/app_views/home/views/widgets/user_Information.dart';
import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/search/views/search_screen.dart';
import 'package:final_project/app_views/sender/views/widgets/sender_view.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/circleImage.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/features/auth/views/screens/splash_view.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../new_inbox/views/new_inbox_screen.dart';
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
              Navigator.pushNamed(context, SearchView.id)
                  .then((value) => context.read<HomeProvider>().init());
            },
            icon: const Icon(Icons.search),
          ),
          Consumer<UserProvider>(
            builder: (context, provider, child) {
              return ResponseBuilder(
                  response: provider.currentUserResponse,
                  onComplete: (_, user, __) {
                    return PopupMenuButton(
                      position: PopupMenuPosition.under,
                      itemBuilder: (BuildContext context2) {
                        return <PopupMenuEntry<dynamic>>[
                          PopupMenuItem(
                            child: UserInformationDialog(
                              user: user,
                              onTapLogout: () {
                                _logout(context, provider);
                              },
                            ),
                          ),
                        ];
                      },
                      child: UserAccountImage(
                        imagePath: user.image ?? '',
                      ),
                    );
                  });
            },
          ),
          /* IconButton(
              onPressed: () async {
                MailRepository().createMail(
                  statusId: '4',
                  decision: "not yet",
                  senderId: '81',
                  finalDecision: "",
                  activities: [],
                  tags: [1],
                  subject: 'test create email',
                  description: "I hate my self",
                  archiveNumber: '/2000',
                  archiveDate: DateTime.now().toString(),
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
            ),
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
            padding: EdgeInsets.only(
                top: 20.h, left: 20.w, right: 20.w, bottom: 90.h),
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
                              mailsCards: []..listMail(mails),
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
                                mailsCards: const [],
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
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              constraints: BoxConstraints.tightFor(height: 1.sh - 60.h),
              clipBehavior: Clip.hardEdge,
              builder: (c2) {
                return ChangeNotifierProvider(
                  create: (context) => NewInboxProvider(),
                  child: const NewInbox(),
                );
              });
        },
        child: const InBoxButton(),
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

class UserAccountImage extends StatelessWidget {
  const UserAccountImage({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 33.w),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: kWhite,
            width: 3,
          )),
      child: CircleImage(
        imagePath: imagePath,
        size: 40,
      ),
    );
  }
}
