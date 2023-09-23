import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/home/views/home_screen.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/sub_app_bar.dart';
import 'package:final_project/app_views/users_management/screens/all_users/all_users.dart';
import 'package:final_project/app_views/users_management/screens/create_user/create_user.dart';
import 'package:flutter/material.dart';

class UsersManagement extends StatelessWidget {
  static const id = "user-management";
  const UsersManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
        title: context.tr("User Management"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Core(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AllUsersView.id);
                },
                leading: const Icon(Icons.group),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: Text(context.tr("Get all users")),
              ),
            ),
            const SSizedBox(
              height: 16,
            ),
            Core(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, CreateUserScreen.id);
                },
                leading: const Icon(Icons.add_circle_outlined),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: Text(context.tr("Create users")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
