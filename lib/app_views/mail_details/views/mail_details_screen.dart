import 'package:final_project/app_views/mail_details/details_provider/details_provider.dart';
import 'package:final_project/app_views/mail_details/views/widgets/mail_options_sheet.dart';
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
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/image_picker.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/activity.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          if (getUser().role?.id == adminId)
            Consumer<DetailsProvider>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    Expanded(
                      child: SheetBar(
                        onTapDone: () async {
                          provider.updateEmail().then((value) {
                            handelResponseStatus(
                                provider.updateResponse!.status, context,
                                message: provider.updateResponse!.message);
                            Navigator.pop(context, true);
                          });
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => MailOptionsSheet(
                              subject: provider.mail.subject ?? '',
                              onTapArchive: () {},
                              onTapShare: () {},
                              onTapDelete: () {
                                provider.deleteMail().then((value) =>
                                    handelResponseStatus(
                                        provider.deleteResponse!.status,
                                        context,
                                        message: provider.deleteResponse!
                                            .message, onComplete: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context, true);
                                    }));
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          color: kLightSub,
                        )),
                  ],
                );
              },
            ),
          const SSizedBox(
            height: 4,
          ),
          Text(
            'Mail Details',
            style: kTitleMailCard,
            textAlign: TextAlign.center,
          ),
          const SSizedBox(
            height: 22,
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
                  onTap: getUser().role?.id == adminId
                      ? () {
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
                        }
                      : null,
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
                onTap: getUser().role?.id == adminId
                    ? () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          clipBehavior: Clip.hardEdge,
                          constraints:
                              BoxConstraints.tightFor(height: 1.sh - 60.h),
                          builder: (context) => StatusSheet(
                              selectedStatus: provider.selectedStatus,
                              onTapDone: (selectedStatus) {
                                provider.setStatus(selectedStatus);
                                Navigator.pop(context);
                              }),
                          context: context,
                        );
                      }
                    : null,
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
                enabled: getUser().role?.id == adminId &&
                    provider.selectedStatus?.id != 4,
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
                      onTapCamera: () {
                        pickCameraImage().then((file) {
                          if (file != null) {
                            provider
                                .addAttachment([Attachment(image: file.path)]);
                            Navigator.pop(context);
                          }
                        });
                      },
                      onTapGallery: () async {
                        pickMullImage().then((files) {
                          if (files.isNotEmpty) {
                            provider.addAttachment(files
                                .map((e) => Attachment(image: e.path))
                                .toList());
                            Navigator.pop(context);
                          }
                        });
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
              if (provider.activities.isNotEmpty) {
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
              } else {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 16, bottom: 10, top: 10),
                  child: Text(
                    'Activities'.firstCapital(),
                    style: tagTitleTextStyle,
                  ),
                );
              }
            },
          ),
          if (getUser().role?.id == adminId) ...[
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
          ]
        ],
      ),
    );
  }
}
