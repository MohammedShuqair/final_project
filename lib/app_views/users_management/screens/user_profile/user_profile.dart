import "package:easy_localization/easy_localization.dart";
import "package:final_project/app_views/current_user_profile/views/widgets/info_tile.dart";
import "package:final_project/app_views/shared/circleImage.dart";
import "package:final_project/app_views/shared/core_background.dart";
import "package:final_project/app_views/shared/custom_sized_box.dart";
import "package:final_project/app_views/shared/responce_builder.dart";
import "package:final_project/app_views/shared/sub_app_bar.dart";
import "package:final_project/app_views/users_management/providers/global_user_provider.dart";
import "package:final_project/app_views/users_management/screens/user_profile/widgets/update_user_dialog.dart";
import "package:final_project/core/util/colors.dart";
import "package:final_project/core/util/constants.dart";
import "package:final_project/core/util/extensions.dart";
import "package:final_project/core/util/styles.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

class UserProfileScreen extends StatelessWidget {
  static const id = "/userProfileScreen";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
        title: context.tr("Profile"),
        actions: [
          Consumer<GlobalUserProvider>(
            builder: (context, provider, child) {
              return IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return UpdateUserDialog(onTapSave: (name, roleId) {
                            provider
                                .updateUser(name, roleId)
                                .then((value) => Navigator.pop(context));
                          });
                        });
                  },
                  icon: const Icon(Icons.edit));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          context.read<GlobalUserProvider>().getSingleUser();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<GlobalUserProvider>(
            builder: (context, provider, child) {
              return ResponseBuilder(
                response: provider.singleUser,
                onComplete: (_, user, __, ___) => ListView(
                  children: [
                    UnconstrainedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleImage(
                          imagePath: '$imageUrl${user.image}',
                          size: 200.w,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Core(
                        child: Column(
                      children: [
                        Text(
                          context.tr('Personal Information'),
                          style: k18Seme.copyWith(color: kText),
                        ),
                        if (user.name != null) ...[
                          const SSizedBox(
                            height: 8,
                          ),
                          InfoTile(
                            hint: '${context.tr('Name')}:',
                            info: user.name!.firstCapital(),
                          ),
                        ],
                        if (user.role != null && user.role?.name != null) ...[
                          const SSizedBox(
                            height: 8,
                          ),
                          InfoTile(
                            hint: '${context.tr('Role')}:',
                            info: user.role!.name!.firstCapital(),
                          ),
                        ],
                        if (user.email != null) ...[
                          const SSizedBox(
                            height: 8,
                          ),
                          InfoTile(
                            hint: '${context.tr('Email')}:',
                            info: user.email ?? context.tr('Email'),
                          ),
                        ],
                      ],
                    )),
                    const SSizedBox(
                      height: 40,
                    ),
                  ],
                ),
                onLoading: (_) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
