import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/sender/provider/sender_search_provider.dart';
import 'package:final_project/app_views/sender/views/widgets/sender_list.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/models/sender_response.dart';
import 'package:final_project/features/sender/repo/sender_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PickSenderView extends StatelessWidget {
  const PickSenderView({
    Key? key,
    required this.onTapSender,
    required this.onTapCreateSender,
  }) : super(key: key);
  final void Function(Sender sender) onTapSender;
  final void Function(String newSender) onTapCreateSender;

  /* String? senderName;

  late ApiResponse<SenderResponse> allSenderResponse;

  @override
  void initState() {
    getAllSenders(1);
    super.initState();
  }*/

  /*Future<void> getAllSenders(int pageNum,) async {
    allSenderResponse = ApiResponse.loading(message: 'logging...');
    setState(() {});
    try {
      final SenderResponse senderResponse =
      await SenderRepository().getAllSender(pageNum, false);
      if (senderName != null && senderResponse.senders != null) {
        senderResponse.senders
            ?.removeWhere((sender) => !sender.name!.contains(senderName!));
      }
      allSenderResponse = ApiResponse.completed(senderResponse,
          message: 'Senders fetched successfully');

      setState(() {});
    } catch (e, s) {
      allSenderResponse = ApiResponse.error(message: e.toString());
      setState(() {});
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
        children: [
          Row(
            children: [
              Expanded(
                child: Consumer<SenderSearchProvider>(
                  builder: (context, provider, child) {
                    return CustomSearchBar(
                      onSubmitted: (name) => provider.onSearchSubmitted(name),
                      onCancel: () {},
                    );
                  },
                ),
              ),
              const SSizedBox(
                width: 8,
              ),
              ActionButton(
                  hint: context.tr('cancel'),
                  onTap: () {
                    Navigator.pop(context, {});
                  })
            ],
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
                  onLoading: (_) {
                    return SenderList(
                      isShimmer: true,
                      senders: List.generate(
                          5, (index) => Sender(name: lorem(words: 1))),
                    );
                  },
                  onComplete: (_, senderResponse, __, more) {
                    if (senderResponse.senders != null &&
                        senderResponse.senders!.isNotEmpty) {
                      return SenderList(
                          senders: senderResponse.senders ?? [],
                          onTapSender: onTapSender);
                    } else {
                      if (provider.senderName?.isNotEmpty ?? false) {
                        return InkWell(
                          onTap: () => onTapCreateSender(provider.senderName!),
                          child: Text('create ${provider.senderName} Sender'),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  });
            },
          ),
        ],
      ),
    );
  }
}
