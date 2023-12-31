import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/archive_number.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/decision_field.dart';
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
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/image_picker.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/activity_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/send_activity_bar.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_tile.dart';
import 'package:final_project/features/mail/models/activity.dart';
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
                    provider.createMail().then((value) {
                      handelResponseStatus(
                          provider.createMailResponse!.status, context,
                          message: provider.createMailResponse!.message,
                          onComplete: () {
                        Navigator.pop(context, true);
                      });
                    });
                  },
                  hint: context.tr("new_inbox"),
                );
              },
            ),
            const SSizedBox(
              height: 17,
            ),
            const SenderCard(),
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
                    return CustomDatePicker(
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
            Selector<NewInboxProvider, TextEditingController>(
              selector: (_, provider) => provider.decision,
              builder: (context, value, child) {
                return DecisionCard(
                  controller: value,
                );
              },
            ),
            const SSizedBox(
              height: 16,
            ),
            Consumer<NewInboxProvider>(
              builder: (context, provider, child) {
                return PickImageView(
                  images: provider.attachments
                      .map((e) => Attachment(image: e.path))
                      .toList(),
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
                if (provider.activities.isNotEmpty) {
                  return ExpansionWidget(
                    title: context.tr('Activities'),
                    cards: provider.activities.map(
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
                } else {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 16, bottom: 10, top: 10),
                    child: Text(
                      context.tr('Activities'.firstCapital()),
                      style: tagTitleTextStyle,
                    ),
                  );
                }
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
