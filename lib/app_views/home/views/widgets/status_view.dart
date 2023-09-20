import 'package:final_project/app_views/home/provider/single_status_provider.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StatusMailsView extends StatelessWidget {
  const StatusMailsView({
    Key? key,
  }) : super(key: key);
  static const String id = '/statusMailsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: kLightSub,
            )),
        title: Text(
          context.read<SingleStatusProvider>().selectedStatus.name ?? 'Tag',
          style: kTitleMailCard,
        ),
      ),
      body: Consumer<SingleStatusProvider>(
        builder: (context, provider, child) {
          return ResponseBuilder(
            response: provider.singleStatus,
            onComplete: (_, data, __, more) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
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
                                .read<SingleStatusProvider>()
                                .getSingleStatus());
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
            },
            onLoading: (_) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 17.h),
              child: ExpansionsShimmer(
                titles: defaultCategories.map((e) => e.name).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
