import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/circleImage.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/shimmers/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/sub_app_bar.dart';
import 'package:final_project/app_views/users_management/management_provider/management_provider.dart';
import 'package:final_project/core/util/constants.dart';
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
          await context.read<ManagementProvider>().getAllRoles();
        },
        child: Consumer<ManagementProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 20.w,
              ),
              child: ResponseBuilder(
                response: provider.allRoles,
                onComplete: (_, roles, message, more) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (_, index) {
                            return ExpansionWidget(
                              key: ValueKey(roles[index].hashCode),
                              cards: roles[index]
                                      .users
                                      ?.map((e) => ListTile(
                                            leading: CircleImage(
                                                imagePath:
                                                    '${imageUrl}${e.image}'),
                                            title: Text(e.name ?? 'name'),
                                            subtitle: Text(e.email ?? 'email'),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
