import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/new_inbox/provider/provider.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/category_sheet.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/pick_sender.dart';
import 'package:final_project/app_views/sender/provider/sender_search_provider.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SenderCard extends StatelessWidget {
  const SenderCard({Key? key}) : super(key: key);

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
                    return context.tr("enter_sender");
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => ChangeNotifierProvider(
                              create: (BuildContext context) =>
                                  SenderSearchProvider(false),
                              child: PickSenderView(
                                onTapSender: (Sender sender) {
                                  context
                                      .read<NewInboxProvider>()
                                      .setSender(sender);
                                  Navigator.pop(context);
                                },
                                onTapCreateSender: (String newSender) {
                                  context
                                      .read<NewInboxProvider>()
                                      .addSenderName(newSender);
                                  Navigator.pop(context);
                                },
                              ),
                            ));
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: kLightSub,
                  ),
                ),
                hintText: context.tr("sender"),
                controller: context.watch<NewInboxProvider>().senderName,
              ),
              const Divider(
                color: Color(0xFFD0D0D0),
              ),
              AppTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.tr('enter_mobile');
                  } else if (value.length < 10) {
                    return context.tr('enter_valid_mobile');
                  }
                  return null;
                },
                enabled: provider.pickedSender == null,
                controller: context.watch<NewInboxProvider>().senderMobile,
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
                enabled: provider.pickedSender == null,
                controller: context.watch<NewInboxProvider>().senderAddress,
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
                onTap: provider.pickedSender != null
                    ? null
                    : () {
                        context.read<NewInboxProvider>().getAllCategories();
                        Scaffold.of(context).showBottomSheet(
                            (context) => const CategorySheet());
                      },
                leading: Text(
                  context.tr("category"),
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
                            onComplete: (BuildContext context, data,
                                String? message, status) {
                              return Text(
                                context.tr(provider.selectedCategory.name!
                                    .firstCapital()),
                                style: kNormal14Color7c,
                              );
                            },
                            onLoading: (_) {
                              return CustomShimmer(
                                child: Text(
                                  context.tr("category"),
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
