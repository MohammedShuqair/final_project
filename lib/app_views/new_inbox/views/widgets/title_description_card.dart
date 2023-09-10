import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class TitleDescriptionCard extends StatelessWidget {
  const TitleDescriptionCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Core(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            hintText: "Title of mail",
            hintStyle: kHintSimi20AF,
          ),
          const Divider(
            color: Color(0xFFD0D0D0),
          ),
          AppTextField(
            hintText: "Description",
            hintStyle: kHintNormal14AF,
          ),
        ],
      ),
    );
  }
}
