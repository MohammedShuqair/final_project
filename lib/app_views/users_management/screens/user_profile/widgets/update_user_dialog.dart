import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/action_button.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateUserDialog extends StatefulWidget {
  const UpdateUserDialog({
    super.key,
    required this.onTapSave,
  });
  final void Function(String? name, int? path) onTapSave;

  @override
  State<UpdateUserDialog> createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  int? roleId;
  String? name;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: Text(
          context.tr("Update user information"),
          style: k18Seme.copyWith(color: kText),
        ),
        content: FormField<String?>(validator: (path) {
          if (roleId == null && name == null) {
            return context
                .tr('update username or user role before saving changes');
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
                    hintText: 'Name'.tr(),
                    hintStyle: k14Normal,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SSizedBox(
                height: 12,
              ),
              const SSizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(context.tr("Role")),
                  const SSizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: roleId,
                      hint: Text(context.tr("select role")),
                      items: defaultRoles
                          .map(
                            (e) => DropdownMenuItem<int>(
                              onTap: () => setState(() {
                                roleId = e.id;
                              }),
                              value: e.id,
                              child: Text(context
                                  .tr(e.name?.firstCapital().tr() ?? 'Name')),
                            ),
                          )
                          .toList() /*const [
                                  DropdownMenuItem(child: Text("ali")),
                                ]*/
                      ,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
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
            hint: 'cancel'.tr(),
            onTap: () => Navigator.pop(context),
            color: kText,
          ),
          const SSizedBox(
            width: 8,
          ),
          ActionButton(
            hint: 'save'.tr(),
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                widget.onTapSave(name?.trim(), roleId);
              }
            },
          ),
        ],
      ),
    );
  }
}
