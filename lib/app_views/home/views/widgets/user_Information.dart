import 'dart:convert';

import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/colors.dart';
import '../../../../core/util/styles.dart';

class UserInformationDialog extends StatelessWidget {
  const UserInformationDialog(
      {Key? key, required this.user, required this.onTapLogout})
      : super(key: key);
  final User user;
  final void Function() onTapLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      '$imageUrl${user.image}',
                      width: 100,
                      height: 100,
                    )),
              ),
              const SSizedBox(
                height: 16,
              ),
              Text(
                user.name?.firstCapital() ?? 'Name',
                style: tagTitleTextStyle,
              ),
              const SSizedBox(
                height: 8,
              ),
              Text(
                user.role?.name ?? "Role",
                style: textInUserInformation,
              ),
              const SSizedBox(
                height: 16,
              ),
            ],
          ),
          const Divider(
            color: kSubText,
            thickness: 1.0,
          ),
          const SSizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.language),
                  SSizedBox(
                    width: 16,
                  ),
                  Text(
                    "Arabic",
                    style: textInUserInformation,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: onTapLogout,
                child: const Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Log out",
                      style: textInUserInformation,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
