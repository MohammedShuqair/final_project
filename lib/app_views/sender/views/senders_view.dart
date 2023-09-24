import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/sender/provider/sender_search_provider.dart';
import 'package:final_project/app_views/sender/views/sender_mails.dart';
import 'package:final_project/app_views/sender/views/widgets/sender_list.dart';
import 'package:final_project/app_views/sender/views/widgets/update_sender_sheet.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/app_views/shared/sub_app_bar.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SendersView extends StatelessWidget {
  const SendersView({Key? key}) : super(key: key);
  static const String id = '/senderView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
        title: context.tr("Senders"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        controller: context.watch<SenderSearchProvider>().scrollController,
        children: [
          Consumer<SenderSearchProvider>(
            builder: (context, provider, child) {
              return CustomSearchBar(
                onSubmitted: (String name) => provider.onSearchSubmitted(name),
                onCancel: () => provider.reset(),
              );
            },
          ),
          const SSizedBox(
            height: 48,
          ),
          const Divider(),
          const SSizedBox(
            height: 12,
          ),
          Consumer<SenderSearchProvider>(
            builder: (context, provider, child) {
              return ResponseBuilder(
                response: provider.allSenderResponse,
                onComplete: (_, senderResponse, __, more) {
                  if (senderResponse.senders == null ||
                      senderResponse.senders!.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 0.1.sh),
                      child: Center(
                          child: Text(
                        'No senders found'.tr(),
                        style: kStatusNumberTextStyle,
                      )),
                    );
                  } else {
                    return Column(
                      children: [
                        SenderList(
                            onTapDelete: (sender) =>
                                provider.deleteSender(sender).then((value) {
                                  handelResponseStatus(
                                      provider.deleteResponse!.status, context,
                                      message: provider.deleteResponse?.message,
                                      onComplete: () {
                                    provider.reset();
                                  });
                                }),
                            onTapEdit: (sender) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return UpdateSenderSheet();
                                  });
                            },
                            senders: senderResponse.senders ?? [],
                            onTapSender: (sender) => Navigator.pushNamed(
                                context, SenderMailsView.id,
                                arguments: sender)),
                        if (more)
                          SenderList(
                            isShimmer: true,
                            senders: List.generate(
                                2, (index) => Sender(name: lorem(words: 1))),
                          )
                      ],
                    );
                  }
                },
                onLoading: (_) {
                  return SenderList(
                    isShimmer: true,
                    senders: List.generate(
                        5, (index) => Sender(name: lorem(words: 1))),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
