import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.tr('Please enter email title.');
              }
              return null;
            },
            controller: context.watch<NewInboxProvider>().subject,
            hintText: context.tr("title_of_mail"),
            hintStyle: kHintSimi20AF,
          ),
          const Divider(
            color: Color(0xFFD0D0D0),
          ),
          AppTextField(
            controller: context.watch<NewInboxProvider>().description,
            hintText: context.tr("description"),
            hintStyle: kHintNormal14AF,
          ),
        ],
      ),
    );
  }
}
