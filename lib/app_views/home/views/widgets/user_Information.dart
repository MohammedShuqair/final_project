import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/circleImage.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:flutter/material.dart';
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
                child: CircleImage(
                  imagePath: '$imageUrl${user.image}',
                  size: 100,
                ),
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
              GestureDetector(
                onTap: (){
                  Locale currentLocale = context.locale;
                  if(currentLocale.languageCode == 'en'){
                    context.setLocale(const Locale('ar', 'AR'));
                  }else{
                    context.setLocale(const Locale('en', 'US'));

                  }

                },
                child: Row(
                  children: [
                    const Icon(Icons.language),
                    const SSizedBox(
                      width: 16,
                    ),
                    Text(
                      context.tr("localization"),
                      style: textInUserInformation,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: onTapLogout,
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      context.tr("logout"),
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
