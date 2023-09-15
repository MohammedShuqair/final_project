import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/app_views/shared/status_list.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusSheet extends StatefulWidget {
  const StatusSheet({Key? key, required this.onTapDone, this.selectedStatus})
      : super(key: key);
  final void Function(Status? status) onTapDone;
  final Status? selectedStatus;

  @override
  State<StatusSheet> createState() => _StatusSheetState();
}

class _StatusSheetState extends State<StatusSheet> {
  Status? selected;
  List<Status> all = [];
  late ApiResponse<StatusResponse> allStatus;
  @override
  void initState() {
    selected = widget.selectedStatus;
    getAllStatus();
    super.initState();
  }

  Future<void> getAllStatus() async {
    allStatus = ApiResponse.loading(message: 'logging...');
    setState(() {});
    try {
      final StatusResponse statuses =
          await StatusRepository().getAllStatus(false);
      allStatus = ApiResponse.completed(statuses,
          message: 'Statuses fetched successfully');
      if (statuses.statuses != null) {
        all.addAll(statuses.statuses!);
      }
      setState(() {});
    } catch (e, s) {
      allStatus = ApiResponse.error(message: e.toString());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 14.0.h, bottom: 57.h),
          child: SheetBar(
              onTapDone: () => widget.onTapDone(selected), hint: 'Statuses'),
        ),
        Core(
          child: ResponseBuilder(
            response: allStatus,
            onComplete: (_, __, ___) => StatusList(
                statuses: all,
                selectedStatus: selected,
                onTap: (s) {
                  setState(() {
                    if (selected?.id == s?.id) {
                      selected = null;
                    } else {
                      selected = s;
                    }
                  });
                }),
            onLoading: (_) => CustomShimmer(
              child: StatusList(
                statuses:
                    List.generate(4, (index) => Status(name: lorem(words: 1))),
                onTap: (s) {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
