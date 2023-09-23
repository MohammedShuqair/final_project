import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/action_button.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/image_tile.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import "package:final_project/core/util/image_picker.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDialog extends StatefulWidget {
  const UpdateDialog({
    super.key,
    required this.onTapSave,
  });
  final void Function(String? name, String? path) onTapSave;

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  String? imagePath;
  String? name;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: Text(
          'Update user information',
          style: k18Seme.copyWith(color: kText),
        ),
        content: FormField<String?>(validator: (path) {
          if (imagePath == null && name == null) {
            return context
                .tr('update username or user image before saving changes');
          }
          return null;
        }, builder: (state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'update name',
                style: kF14N,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 20.w, top: 4.h),
                child: TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Name',
                    hintStyle: k14Normal,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SSizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'update image',
                    style: kF14N,
                  ),
                  if (imagePath == null) ...[
                    ElevatedButton(
                        onPressed: () async {
                          XFile? file = await pickGelleryImage();
                          setState(() {
                            imagePath = file?.path;
                          });
                        },
                        child: const Text('Pick image'))
                  ],
                ],
              ),
              if (imagePath != null) ...[
                const SSizedBox(
                  height: 8,
                ),
                ImageTile(
                    image: imagePath!,
                    fromNetwork: false,
                    onTapDelete: () {
                      File(imagePath!).delete();
                      setState(() {
                        imagePath = null;
                      });
                    }),
              ],
              if (state.hasError && state.errorText != null) ...[
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 10.h, start: 28.w),
                  child: Text(
                    state.errorText!,
                    style: kSearchText.copyWith(
                        color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ]
            ],
          );
        }),
        actions: [
          ActionButton(
            hint: 'cancel',
            onTap: () => Navigator.pop(context),
            color: kText,
          ),
          const SSizedBox(
            width: 8,
          ),
          ActionButton(
            hint: 'save',
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                widget.onTapSave(name?.trim(), imagePath);
              }
            },
          ),
        ],
      ),
    );
  }
}
