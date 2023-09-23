import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/widgets/app_drawer.dart';
import 'package:final_project/app_views/home/views/widgets/home_app_bar.dart';
import 'package:final_project/app_views/home/views/widgets/new_inbox_btn.dart';
import 'package:final_project/app_views/home/views/widgets/status_grid_view.dart';
import 'package:final_project/app_views/home/views/widgets/tags_widget.dart';
import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/shimmers/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:flutter/material.dart';
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
      appBar: const HomeAppBar(),
      drawer: const Drawer(
        child: AppDrawer(),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          context.read<HomeProvider>().init();
          await context.read<UserProvider>().getCurrentUser();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
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
                      onComplete: (_, data, message, more) {
                        return Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                String key = data.keys.elementAt(index);
                                List<Mail> mails = data[key] ?? [];
                                return ExpansionWidget(
                                  key: ValueKey(data.hashCode),
                                  cards: []..listMail(mails, (mail) {
                                      showMailDetailsSheet(
                                          context,
                                          mail,
                                          () async => context
                                              .read<HomeProvider>()
                                              .init());
                                    }),
                                  title: context.tr(key),
                                );
                              },
                              separatorBuilder: (_, index) {
                                return const SSizedBox(
                                  height: 14,
                                );
                              },
                              itemCount: data.length,
                            ),
                            if (more)
                              ExpansionsShimmer(
                                titles: defaultCategories
                                    .map((e) => e.name)
                                    .toList()
                                  ..removeWhere((newCat) => data.keys
                                      .any((oldCat) => newCat == oldCat)),
                              )
                          ],
                        );
                      },
                      onLoading: (_) {
                        return ExpansionsShimmer(
                          titles: defaultCategories.map((e) => e.name).toList(),
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
                        context.tr("tags"),
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
          showModalBottomSheet<bool?>(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints.tightFor(height: 1.sh - 60.h),
                  clipBehavior: Clip.hardEdge,
                  builder: (c2) {
                    return ChangeNotifierProvider(
                      create: (context) => NewInboxProvider(),
                      child: const NewInbox(),
                    );
                  })
              .then((value) =>
                  value ?? false ? context.read<HomeProvider>().init() : null);
        },
        child: const InBoxButton(),
      ),
    );
  }
}
