import 'package:final_project/app_views/sender/views/widgets/sender_list.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/sender/models/sender_response.dart';
import 'package:final_project/features/sender/repo/sender_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickSenderView extends StatefulWidget {
  const PickSenderView({Key? key}) : super(key: key);

  @override
  State<PickSenderView> createState() => _PickSenderViewState();
}

class _PickSenderViewState extends State<PickSenderView> {
  String? senderName;

  late ApiResponse<SenderResponse> allSenderResponse;
  @override
  void initState() {
    getAllSenders(1);
    super.initState();
  }

  Future<void> getAllSenders(
    int pageNum,
  ) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchBar(
                  onSubmitted: (String value) {
                    senderName = value;
                    getAllSenders(1);
                  },
                  onCancel: () {},
                ),
              ),
              const SSizedBox(
                width: 8,
              ),
              ActionButton(
                  hint: 'Cancel',
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
          ResponseBuilder(
              response: allSenderResponse,
              onComplete: (_, senderResponse, __) {
                if (senderResponse.senders != null &&
                    senderResponse.senders!.isNotEmpty) {
                  return SenderList(
                      senders: senderResponse.senders ?? [],
                      onTapSender: (s) {
                        Navigator.pop(context, {'sender': s});
                      });
                } else {
                  if (senderName?.isNotEmpty ?? false) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, {'name': senderName});
                      },
                      child: Text('create $senderName Sender'),
                    );
                  } else {
                    return const SizedBox();
                  }
                }
              }),
        ],
      ),
    );
  }
}
