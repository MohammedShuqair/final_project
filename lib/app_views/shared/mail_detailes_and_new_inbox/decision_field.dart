import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecisionCard extends StatelessWidget {
  const DecisionCard({Key? key, required this.controller, this.enabled = true})
      : super(key: key);
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Core(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("decision"),
            style: kTitleMailCard,
          ),
          AppTextField(
            enabled: enabled,
            controller: controller,
            hintText:  context.tr("decision"),
            hintStyle: kHintNormal14AF.copyWith(color: const Color(0xff898989)),
          ),
        ],
      ),
    );
  }
}
