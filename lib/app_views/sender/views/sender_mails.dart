import 'package:final_project/app_views/sender/provider/single_sender_provider.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/shimmers/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sub_app_bar.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SenderMailsView extends StatelessWidget {
  const SenderMailsView({
    Key? key,
  }) : super(key: key);
  static const String id = '/senderMailsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(
          title: context
                  .select<SingleSenderProvider, Sender>(
                      (value) => value.selectedSender)
                  .name ??
              'Name'),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await context.read<SingleSenderProvider>().getSingleSender();
        },
        child: Selector<SingleSenderProvider,
            ApiResponse<Map<String, List<Mail>>>>(
          selector: (context, provider) => provider.singleSender,
          builder: (context, response, child) {
            return ResponseBuilder(
              response: response,
              onComplete: (_, data, __, more) {
                if (data.isNotEmpty) {
                  return ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
                    itemBuilder: (_, index) {
                      String key = data.keys.elementAt(index);
                      List<Mail> mails = data[key] ?? [];
                      return ExpansionWidget(
                        title: key,
                        cards: []..listMail(mails, (mail) {
                            showMailDetailsSheet(
                                context,
                                mail,
                                () async => context
                                    .read<SingleSenderProvider>()
                                    .getSingleSender());
                          }),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SSizedBox(
                        height: 14,
                      );
                    },
                    itemCount: data.length,
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 0.1.sh),
                    child: Center(
                        child: Text(
                      'No Mails found',
                      style: kStatusNumberTextStyle,
                    )),
                  );
                }
              },
              onError: (_, message) {
                return Text(message ?? '');
              },
              onLoading: (_) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
                child: ExpansionsShimmer(
                  titles: [
                    ...[
                      context
                          .read<SingleSenderProvider>()
                          .selectedSender
                          .category
                          ?.name
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
