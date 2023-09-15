import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/archive_number.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/decision_field.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/sender_category_card.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/title_description_card.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/date_picker.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/pick_image_view.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_sheet.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_tile.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_sheet.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/image_picker.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/activity_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/send_activity_bar.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_tile.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../shared/mail_detailes_and_new_inbox/pick_image_sheet.dart';

class NewInbox extends StatelessWidget {
  const NewInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.watch<NewInboxProvider>().scaffoldKey,
      body: Form(
        key: context
            .select<NewInboxProvider, GlobalKey<FormState>>((v) => v.formKey),
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 20.w,
          ),
          children: [
            Consumer<NewInboxProvider>(
              builder: (context, provider, child) {
                return SheetBar(
                  onTapDone: () {
                    print(provider.archiveDate);

                    if (provider.formKey.currentState?.validate() ?? false) {
                      print(provider.archiveDate);
                      // Navigator.pop(context, {});
                    }
                  },
                  hint: 'New Inbox',
                );
              },
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
            Core(
                child: Column(
              children: [
                Consumer<NewInboxProvider>(
                  builder: (context, provider, child) {
                    return DatePiker(
                      selectedDate: provider.archiveDate,
                      onChangeDate: (DateTime newDate) {
                        provider.setArchiveDate(newDate);
                      },
                    );
                  },
                ),
                const Divider(),
                const ArchiveWidget(),
              ],
            )),
            const SSizedBox(
              height: 19,
            ),
            Consumer<NewInboxProvider>(
              builder: (context, provider, child) {
                return TagTiles(
                  tags: provider.selectedTags,
                  onTap: () {
                    provider.getAllTags();
                    provider.scaffoldKey.currentState
                        ?.showBottomSheet((context) => TagSheet(
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
                    provider.scaffoldKey.currentState?.showBottomSheet(
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
                return PickImageView(
                  fromNetwork: false,
                  images: provider.attachments.map((e) => e.path).toList(),
                  onTapAddImage: () {
                    provider.scaffoldKey.currentState?.showBottomSheet(
                      (context) => PickImageSheet(
                        onTapCamera: () async {
                          XFile? file = await pickCameraImage();
                          if (file != null) {
                            provider.addAttachment([file]);
                            Navigator.pop(context);
                          }
                        },
                        onTapGallery: () async {
                          List<XFile> files = await pickMullImage();
                          if (files.isNotEmpty) {
                            provider.addAttachment(files);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    );
                  },
                  onTapDelete: (String path) {
                    provider.removeAttachment(path);
                  },
                );
              },
            ),
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
      ),
    );
  }
}
