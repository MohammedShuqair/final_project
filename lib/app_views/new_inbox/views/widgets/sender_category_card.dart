import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/category_sheet.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/pick_sender.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SenderMobileCategoryCard extends StatelessWidget {
  const SenderMobileCategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewInboxProvider>(
      builder: (context, provider, child) {
        return Core(
          color: provider.pickedSender != null ? Colors.transparent : null,
          noShadow: provider.pickedSender != null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender name.';
                  }
                  return null;
                },
                enabled: provider.pickedSender == null,
                prefixIcon: const Icon(
                  Icons.person_2_outlined,
                  color: Color(0xFF707070),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    showModalBottomSheet<Map>(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => const PickSenderView()).then((value) {
                      if (value?['sender'] != null) {
                        context
                            .read<NewInboxProvider>()
                            .setSender(value?['sender']);
                      }
                      if (value?['name'] != null) {
                        context
                            .read<NewInboxProvider>()
                            .addSenderName(value?['name']);
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: kLightSub,
                  ),
                ),
                hintText: "Sender",
                controller: context.watch<NewInboxProvider>().senderName,
              ),
              const Divider(
                color: Color(0xFFD0D0D0),
              ),
              AppTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sender mobile number.';
                  }
                  return null;
                },
                enabled: provider.pickedSender == null,
                controller: context.watch<NewInboxProvider>().senderMobile,
                prefixIcon: const Icon(
                  Icons.phone_android,
                  color: Color(0xFF707070),
                ),
                hintText: "Mobile",
              ),
              const Divider(
                color: Color(0xFFD0D0D0),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: provider.pickedSender != null
                    ? null
                    : () {
                        context.read<NewInboxProvider>().getAllCategories();
                        Scaffold.of(context).showBottomSheet(
                            (context) => const CategorySheet());
                      },
                leading: Text(
                  "Category",
                  style: kHintNormal16Dark,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<NewInboxProvider>(
                      builder: (context, provider, child) {
                        if (provider.allCategoryResponse != null) {
                          return ResponseBuilder(
                            response: provider.allCategoryResponse,
                            onComplete:
                                (BuildContext context, data, String? message) {
                              return Text(
                                provider.selectedCategory.name!.firstCapital(),
                                style: kNormal14Color7c,
                              );
                            },
                            onLoading: (_) {
                              return CustomShimmer(
                                child: Text(
                                  "Category",
                                  style: kNormal14Color7c,
                                ),
                              );
                            },
                          );
                        } else {
                          return Text(
                            provider.selectedCategory.name!.firstCapital(),
                            style: kNormal14Color7c,
                          );
                        }
                      },
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: kSubText,
                    ),
                    const SSizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
