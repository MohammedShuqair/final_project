import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/current_user_profile/current_user_profile.dart';
import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/sender/views/senders_view.dart';
import 'package:final_project/app_views/users_management/users_management_screen.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/colors.dart';

class AppDrawer extends StatefulWidget {
  static const String id = '/appDrawer';
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkSub,
      child: ListView(
        children: [
          UnconstrainedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 64.0.h),
              child: Image.asset(
                'assets/images/palestine_bird.png',
                height: 103,
                width: 67,
                fit: BoxFit.cover,
              ),
            ),
          ),
          /*DrawerTile(
            title: context.tr('Home'),
            onTap: () {},
            iconPath: 'assets/icons/home.png',
          ),*/
          DrawerTile(
            title: context.tr('Profile'),
            onTap: () {
              Navigator.pushNamed(context, CurrentUserProfileScreen.id)
                  .then((value) => context.read<HomeProvider>().init());
            },
            iconPath: 'assets/icons/profile_user.png',
          ),
          if (getUser().role?.id == adminId)
            DrawerTile(
              title: context.tr('Senders'),
              onTap: () => Navigator.pushNamed(context, SendersView.id)
                  .then((value) => context.read<HomeProvider>().init()),
              icon: const Icon(
                Icons.send,
                color: kWhite,
              ),
            ),
          if (getUser().role?.id == adminId)
            DrawerTile(
              title: context.tr('Users Management'),
              onTap: () => Navigator.pushNamed(context, UsersManagement.id)
                  .then((value) => context.read<HomeProvider>().init()),
              iconPath: 'assets/icons/settings.png',
            ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.title,
    required this.onTap,
    this.iconPath,
    this.icon,
  });
  final String title;
  final String? iconPath;
  final Widget? icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: iconPath != null && icon == null
          ? Image.asset(
              iconPath!,
              height: 20,
              width: 20,
              fit: BoxFit.cover,
            )
          : icon,
      title: Text(
        title,
        style: kF16N,
      ),
    );
  }
}
