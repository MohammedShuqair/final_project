import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class DecisionCard extends StatelessWidget {
  const DecisionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Core(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Decision",
            style: kTitleMailCard,
          ),
          AppTextField(
            hintText: "Decision",
            hintStyle: kHintNormal14AF.copyWith(color: Color(0xff898989)),
          ),
        ],
      ),
    );
  }
}
