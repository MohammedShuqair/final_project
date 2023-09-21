import 'package:final_project/app_views/sender/views/sender_view.dart';
import 'package:final_project/app_views/users_management/profile_screen.dart';
import 'package:final_project/app_views/users_management/users_management_screen.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          DrawerTile(
            title: 'Home',
            onTap: () {},
            iconPath: 'assets/icons/home.png',
          ),
          DrawerTile(
            title: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
            iconPath: 'assets/icons/profile_user.png',
          ),
          DrawerTile(
            title: 'Senders',
            onTap: () => Navigator.pushNamed(context, SenderView.id),
            iconPath: 'assets/icons/senders.png',
          ),
          DrawerTile(
            title: 'Users Management',
            onTap: () => Navigator.pushNamed(context, UsersManagement.id),
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
    required this.iconPath,
  });
  final String title;
  final String iconPath;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: Image.asset(
        iconPath,
        height: 20,
        width: 20,
        fit: BoxFit.cover,
      ),
      title: Text(
        title,
        style: kF16N,
      ),
    );
  }
}
