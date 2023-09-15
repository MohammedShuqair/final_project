import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/circleImage.dart';
import 'package:final_project/app_views/shared/select_icon.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityCard extends StatefulWidget {
  static const String id = "/activityCard";
  final Activity activity;
  final void Function(Activity activity)? onTapEdit;
  final void Function(String body, Activity activity)? onTapSaveEdit;
  final bool editingMode;
  final void Function(Activity activity) onTapDelete;
  final void Function(Activity activity)? onTapCancel;
  const ActivityCard(
      {super.key,
      required this.activity,
      this.onTapEdit,
      required this.onTapDelete,
      required this.editingMode,
      this.onTapSaveEdit,
      this.onTapCancel});

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.activity.body ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.0.w, bottom: 10.h),
      child: Core(
        padding: EdgeInsetsDirectional.only(
            start: 16.w, top: 19.h, bottom: 14.h, end: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleImage(
              imagePath: widget.activity.user?.image ?? '',
            ),
            const SSizedBox(
              width: 9,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.activity.user?.name ?? '',
                          style:
                              kStatusNumberTextStyle.copyWith(fontSize: 16.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150.w),
                        child: Text(
                          widget.activity.sendDate ?? '',
                          style: kSearchText,
                          textAlign: TextAlign.end,
                          // maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // const SSizedBox(
                  //   height: 4,
                  // ),
                  AppTextField(
                    focusNode: handelFocusNode(),
                    enabled: widget.editingMode,
                    hintText: '',
                    controller: controller,
                    hintStyle: textInTagTextStyle.copyWith(
                        fontWeight: FontWeight.normal),
                  )
                  // Text(
                  //   activity.body ?? '',
                  //   style: textInTagTextStyle.copyWith(
                  //       fontWeight: FontWeight.normal),
                  //   textAlign: TextAlign.start,
                  // ),
                ],
              ),
            ),
            if (widget.editingMode) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        widget.onTapSaveEdit!(controller.text, widget.activity);
                      },
                      child: const Text('save')),
                  const SSizedBox(
                    width: 4,
                  ),
                  TextButton(
                      onPressed: () {
                        controller.text = widget.activity.body ?? '';
                        widget.onTapCancel!(widget.activity);
                      },
                      child: const Text('cancel')),
                ],
              )
            ],
            if (!widget.editingMode)
              PopupMenuButton(
                  position: PopupMenuPosition.under,
                  itemBuilder: (_) => [
                        PopupMenuItem(
                          onTap: () {
                            widget.onTapDelete(widget.activity);
                          },
                          child: const Text('Delete'),
                        ),
                        if (widget.onTapEdit != null)
                          PopupMenuItem(
                            onTap: () {
                              widget.onTapEdit!(widget.activity);
                            },
                            child: const Text('Edit'),
                          ),
                      ]),
          ],
        ),
      ),
    );
  }

  FocusNode? handelFocusNode() {
    if (widget.editingMode) {
      return FocusNode()..requestFocus();
    }
    return null;
  }
}
