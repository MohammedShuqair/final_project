import 'dart:convert';

import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/archive_number.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/decision_field.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/sender_category_card.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/title_description_card.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_sheet.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_tile.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_sheet.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/activity_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/send_activity_bar.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_tile.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:provider/provider.dart';

class NewInbox extends StatelessWidget {
  const NewInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 20.w,
        ),
        children: [
          SheetBar(
            onTapDone: () {
              Navigator.pop(context, {});
            },
            hint: 'New Inbox',
          ),
          const SSizedBox(
            height: 17,
          ),
          const SenderMobileCategoryCard(),
          const SSizedBox(
            height: 16,
          ),
          const TitleDescriptionCard(),
          const SSizedBox(
            height: 15,
          ),
          const ArchiveWidget(),
          const SSizedBox(
            height: 19,
          ),
          Consumer<NewInboxProvider>(
            builder: (context, provider, child) {
              return TagTiles(
                tags: provider.selectedTags,
                onTap: () {
                  provider.getAllTags();
                  Scaffold.of(context).showBottomSheet((context) => TagSheet(
                        onTapDone: (selected) {
                          provider.setTags(selected);

                          Navigator.pop(
                            context,
                          );
                        },
                        selected: provider.selectedTags,
                      ));
                },
              );
            },
          ),
          const SSizedBox(
            height: 12,
          ),
          Consumer<NewInboxProvider>(
            builder: (context, provider, child) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).showBottomSheet(
                    (context) => StatusSheet(
                        selectedStatus: provider.selectedStatus,
                        onTapDone: (selectedStatus) {
                          provider.setStatus(selectedStatus);
                          Navigator.pop(context);
                        }),
                  );
                },
                child: StatusTile(
                  selectedStatus: provider.selectedStatus,
                ),
              );
            },
          ),
          const SSizedBox(
            height: 12,
          ),
          const DecisionCard(),
          const SSizedBox(
            height: 16,
          ),
          Consumer<NewInboxProvider>(
            builder: (context, provider, child) {
              return ExpansionWidget(
                title: 'Activities',
                mailsCards: provider.activities.map(
                  (activity) {
                    return ActivityCard(
                      key: ValueKey(activity.toString()),
                      activity: activity,
                      onTapSaveEdit: (body, activity) {
                        provider.editActivityBody(body, activity);
                      },
                      onTapCancel: (activity) {
                        provider.removeEditingActivity(activity);
                      },
                      onTapEdit: (Activity activity) {
                        provider.addEditingActivity(activity);
                      },
                      onTapDelete: (Activity activity) {
                        provider.removeActivity(activity);
                      },
                      editingMode:
                          provider.editingActivities.contains(activity),
                    );
                  },
                ).toList(),
              );
            },
          ),
          const SSizedBox(
            height: 12,
          ),
          SendActivityBar(
            onSubmitted: (String value) {
              try {
                context.read<NewInboxProvider>().addActivity(value);
              } catch (e) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthView.id, (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
