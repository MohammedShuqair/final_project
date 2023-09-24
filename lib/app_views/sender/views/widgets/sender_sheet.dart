import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SenderSheet extends StatefulWidget {
  const SenderSheet(
      {Key? key, this.sender, required this.onTapSave, required this.hint})
      : super(key: key);
  final Sender? sender;
  final String hint;
  final void Function(
          int? id, String name, String mobile, String address, String cid)
      onTapSave;

  @override
  State<SenderSheet> createState() => _SenderSheetState();
}

class _SenderSheetState extends State<SenderSheet> {
  GlobalKey<FormState> key = GlobalKey();
  late TextEditingController senderName;
  late TextEditingController senderMobile;
  late TextEditingController senderAddress;
  Category selectedCategory = Category();
  @override
  void initState() {
    senderName = TextEditingController(text: widget.sender?.name ?? '');
    senderMobile = TextEditingController(text: widget.sender?.mobile ?? '');
    senderAddress = TextEditingController(text: widget.sender?.address ?? '');
    selectedCategory.copyWith(
        category: widget.sender?.category ?? defaultCategories[0]);
    print(selectedCategory);
    super.initState();
  }

  @override
  void dispose() {
    senderName.dispose();
    senderMobile.dispose();
    senderAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: FormField<String>(validator: (v) {
          if (senderName.text == (widget.sender?.name ?? '') &&
              senderMobile.text == (widget.sender?.mobile ?? '') &&
              senderAddress.text == (widget.sender?.address ?? '') &&
              selectedCategory.id == widget.sender?.category?.id) {
            return 'please edit sender info'.tr();
          }
        }, builder: (state) {
          return ListView(
            padding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 20.w,
            ),
            children: [
              SheetBar(
                onTapDone: () {
                  if (key.currentState?.validate() ?? false) {
                    widget.onTapSave(
                        widget.sender?.id,
                        senderName.text,
                        senderMobile.text,
                        senderAddress.text,
                        selectedCategory.id.toString());
                  }
                },
                hint: widget.hint,
              ),
              const SSizedBox(
                height: 17,
              ),
              AppTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.tr("enter_sender");
                  }
                  return null;
                },
                prefixIcon: const Icon(
                  Icons.person_2_outlined,
                  color: Color(0xFF707070),
                ),
                hintText: context.tr("sender"),
                controller: senderName,
              ),
              const Divider(
                color: Color(0xFFD0D0D0),
              ),
              AppTextField(
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.tr('enter_mobile');
                  } else if (value.length < 10) {
                    return context.tr('enter_valid_mobile');
                  }
                  return null;
                },
                controller: senderMobile,
                prefixIcon: const Icon(
                  Icons.phone_android,
                  color: Color(0xFF707070),
                ),
                hintText: context.tr("mobile"),
              ),
              const Divider(
                color: Color(0xFFD0D0D0),
              ),
              AppTextField(
                controller: senderAddress,
                prefixIcon: const Icon(
                  Icons.location_city,
                  color: Color(0xFF707070),
                ),
                hintText: context.tr("address"),
              ),
              const Divider(
                color: Color(0xFFD0D0D0),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  context.tr("category"),
                  style: kHintNormal16Dark,
                ),
                title: DropdownButtonFormField<int>(
                  alignment: Alignment.center,
                  value: selectedCategory.id,
                  items: defaultCategories
                      .map(
                        (c) => DropdownMenuItem<int>(
                          onTap: () => setState(() {
                            selectedCategory = c;
                          }),
                          value: c.id,
                          child: Text(context.tr(c.name?.tr() ?? 'Name')),
                        ),
                      )
                      .toList() /*const [
                              DropdownMenuItem(child: Text("ali")),
                            ]*/
                  ,
                  onChanged: (_) {},
                ),
              ),
              if (state.hasError && state.errorText != null) ...{
                Padding(
                    padding: EdgeInsetsDirectional.only(top: 10.h, start: 28.w),
                    child: Text(
                      state.errorText!,
                      style: kSearchText.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ))
              },
            ],
          );
        }),
      ),
    );
  }
}
