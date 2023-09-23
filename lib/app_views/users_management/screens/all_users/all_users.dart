import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/circleImage.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/app_views/shared/shimmers/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/sub_app_bar.dart';
import 'package:final_project/app_views/users_management/providers/management_provider.dart';
import 'package:final_project/app_views/users_management/screens/user_profile/user_profile.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllUsersView extends StatelessWidget {
  const AllUsersView({Key? key}) : super(key: key);
  static const String id = '/allUsersView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
        title: context.tr("All Users"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await context.read<ManagementProvider>().init();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          children: [
            Consumer<ManagementProvider>(
              builder: (context, provider, child) {
                return CustomSearchBar(
                  onSubmitted: provider.search,
                  onCancel: () => provider.reset(),
                );
              },
            ),
            const SSizedBox(
              height: 28,
            ),
            const Divider(),
            Consumer<ManagementProvider>(
              builder: (context, provider, child) {
                return ResponseBuilder(
                  response: provider.allRoles,
                  onComplete: (_, roles, message, more) {
                    return Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return ExpansionWidget(
                              key: ValueKey(roles[index].hashCode),
                              cards: roles[index]
                                      .users
                                      ?.map((e) => ListTile(
                                            key: ValueKey(e.hashCode),
                                            onTap: () => Navigator.pushNamed(
                                                    context,
                                                    UserProfileScreen.id,
                                                    arguments: e)
                                                .then((value) =>
                                                    provider.getAllRoles()),
                                            leading: CircleImage(
                                                imagePath:
                                                    '$imageUrl${e.image}'),
                                            title: Text(e.name ?? 'name'),
                                            subtitle: Text(e.email ?? 'email'),
                                            trailing: TextButton(
                                                onPressed: () {
                                                  provider
                                                      .deleteUser(e.id!)
                                                      .then((value) {
                                                    handelResponseStatus(
                                                        provider.deleteResponse!
                                                            .status,
                                                        context,
                                                        message: provider
                                                            .deleteResponse
                                                            ?.message,
                                                        onComplete: () {
                                                      provider.getAllRoles();
                                                    });
                                                  });
                                                },
                                                child: const Text('delete')),
                                          ))
                                      .toList() ??
                                  [],
                              title: context.tr(roles[index].name ?? 'Role'),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SSizedBox(
                              height: 14,
                            );
                          },
                          itemCount: roles.length,
                        ),
                        if (more)
                          ExpansionsShimmer(
                            titles: defaultRoles.map((e) => e.name).toList()
                              ..removeWhere((newCat) => roles
                                  .map((e) => e.name)
                                  .toList()
                                  .any((oldCat) => newCat == oldCat)),
                          )
                      ],
                    );
                  },
                  onLoading: (_) {
                    return ExpansionsShimmer(
                      titles: defaultRoles.map((e) => e.name).toList(),
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
    );
  }
}
