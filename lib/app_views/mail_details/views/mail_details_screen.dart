import 'package:final_project/app_views/mail_details/details_provider/details_provider.dart';
import 'package:final_project/app_views/mail_details/views/widgets/sender_date_title_descreption.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/activity_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/decision_field.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/pick_image_sheet.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/pick_image_view.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/send_activity_bar.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_sheet.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/status_tile.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_sheet.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_tile.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/image_picker.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MailDetailsView extends StatelessWidget {
  const MailDetailsView({
    Key? key,
  }) : super(key: key);
  static const String id = '/mailDetailsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 20.w,
        ),
        children: [
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return SheetBar(
                  onTapDone: () async {
                    await provider.updateEmail();
                    Navigator.pop(context, true);
                  },
                  hint: 'Mail Details');
            },
          ),
          const SSizedBox(
            height: 17,
          ),
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return SenderDataTitleDescription(
                senderName: provider.mail.sender?.name ?? '',
                categoryName: provider.mail.sender?.category?.name ?? '',
                date: provider.mail.archiveDate?.formatArriveTime() ?? '',
                archiveNumber: provider.mail.archiveNumber ?? '',
                title: provider.mail.subject ?? '',
                description: provider.mail.description,
              );
            },
          ),
          const SSizedBox(
            height: 17,
          ),
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return Form(
                key: provider.formKey,
                child: TagTiles(
                  tags: provider.selectedTags,
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        clipBehavior: Clip.hardEdge,
                        constraints:
                            BoxConstraints.tightFor(height: 1.sh - 60.h),
                        builder: (context) => TagSheet(
                              onTapDone: (selected) {
                                provider.setTags(selected);
                                Navigator.pop(
                                  context,
                                );
                              },
                              selected: provider.selectedTags,
                            ),
                        context: context);
                  },
                ),
              );
            },
          ),
          const SSizedBox(
            height: 12,
          ),
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    clipBehavior: Clip.hardEdge,
                    constraints: BoxConstraints.tightFor(height: 1.sh - 60.h),
                    builder: (context) => StatusSheet(
                        selectedStatus: provider.selectedStatus,
                        onTapDone: (selectedStatus) {
                          provider.setStatus(selectedStatus);
                          Navigator.pop(context);
                        }),
                    context: context,
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
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return DecisionCard(
                controller: provider.decision,
                enabled: provider.selectedStatus?.id != 4,
              );
            },
          ),
          const SSizedBox(
            height: 12,
          ),
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return PickImageView(
                images: provider.attachments,
                onTapAddImage: () {
                  Scaffold.of(context).showBottomSheet(
                    (context) => PickImageSheet(
                      onTapCamera: () async {
                        XFile? file = await pickCameraImage();
                        if (file != null) {
                          provider
                              .addAttachment([Attachment(image: file.path)]);
                          Navigator.pop(context);
                        }
                      },
                      onTapGallery: () async {
                        List<XFile> files = await pickMullImage();
                        if (files.isNotEmpty) {
                          provider.addAttachment(files
                              .map((e) => Attachment(image: e.path))
                              .toList());
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
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return ExpansionWidget(
                title: 'Activities',
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
            },
          ),
          const SSizedBox(
            height: 12,
          ),
          Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return SendActivityBar(
                onSubmitted: (String value) {
                  try {
                    provider.addActivity(value);
                  } catch (e) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AuthView.id, (route) => false);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
