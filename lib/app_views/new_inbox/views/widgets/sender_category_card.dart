import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SenderMobileCategoryCard extends StatelessWidget {
  const SenderMobileCategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Core(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            prefixIcon: const Icon(
              Icons.person_2_outlined,
              color: Color(0xFF707070),
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info_outline,
                color: kLightSub,
              ),
            ),
            hintText: "Sender",
          ),
          const Divider(
            color: Color(0xFFD0D0D0),
          ),
          const AppTextField(
            prefixIcon: Icon(
              Icons.phone_android,
              color: Color(0xFF707070),
            ),
            hintText: "Mobile",
          ),
          const Divider(
            color: Color(0xFFD0D0D0),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Text(
              "Category",
              style: kHintNormal16Dark,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Other",
                  style: kNormal14Color7c,
                ),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: kSubText,
                ),
                const SSizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
