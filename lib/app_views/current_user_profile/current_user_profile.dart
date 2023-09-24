import "package:easy_localization/easy_localization.dart";
import "package:final_project/app_views/current_user_profile/views/widgets/info_tile.dart";
import "package:final_project/app_views/current_user_profile/views/widgets/update_dialog.dart";
import "package:final_project/app_views/shared/circleImage.dart";
import "package:final_project/app_views/shared/core_background.dart";
import "package:final_project/app_views/shared/custom_sized_box.dart";
import "package:final_project/app_views/shared/responce_builder.dart";
import "package:final_project/app_views/shared/sub_app_bar.dart";
import "package:final_project/core/util/colors.dart";
import "package:final_project/core/util/constants.dart";
import "package:final_project/core/util/extensions.dart";
import "package:final_project/core/util/shared_methodes.dart";
import "package:final_project/core/util/styles.dart";
import "package:final_project/features/auth/views/screens/splash_view.dart";
import "package:final_project/features/auth/views/widgets/auth_button.dart";
import "package:final_project/features/current_user/provider/current_user_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

class CurrentUserProfileScreen extends StatelessWidget {
  static const id = "/currentUserProfileScreen";

  const CurrentUserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
        title: context.tr("Profile"),
        actions: [
          Consumer<UserProvider>(
            builder: (context, provider, child) {
              return IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => ResponseBuilder(
                              response: provider.currentUserResponse,
                              onComplete: (_, user, __, ___) {
                                return UpdateDialog(
                                  onTapSave:
                                      (String? name, String? path) async {
                                    await provider
                                        .updateUser(name ?? user.name!,
                                            imagePath: path)
                                        .then((value) {
                                      handelResponseStatus(
                                          provider.currentUserResponse.status,
                                          context,
                                          message: provider
                                              .currentUserResponse.message,
                                          onComplete: () =>
                                              Navigator.pop(context));
                                    });
                                  },
                                );
                              },
                            ));
                  },
                  icon: const Icon(Icons.edit));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<UserProvider>().getCurrentUser();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<UserProvider>(
            builder: (context, provider, child) {
              return ResponseBuilder(
                response: provider.currentUserResponse,
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
                    AuthButton(
                        gradient: const [kUnselect, kSubText],
                        textColor: kDarkText,
                        onTap: () {
                          provider.logout().then((value) {
                            handelResponseStatus(
                                provider.currentUserResponse.status, context,
                                message: provider.currentUserResponse.message,
                                onComplete: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, SplashView.id, (route) => false);
                            });
                          });
                        },
                        text: context.tr('logout'))
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
