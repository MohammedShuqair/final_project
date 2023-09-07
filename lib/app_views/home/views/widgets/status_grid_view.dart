import 'dart:ffi';

import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/app_views/home/views/widgets/status_widget.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:provider/provider.dart';

import '../../../../features/status/provider/status_provider.dart';

class StatusGridView extends StatelessWidget {
  const StatusGridView({
    Key? key,
  }) : super(key: key);

  static const List<String> statusTextsList = [
    "Inbox",
    "Pending",
    "In Progress",
    "Completed"
  ];
  static const List<Color> statusColorsList = [
    kInbox,
    kPending,
    kLightSub,
    kCompleted
  ];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: deviceSize.width > 400 ? 1.5 / 0.5 : 1.5 / 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return StatusWidget(
          statusColor: statusColorsList[
              index] /*Color(int.parse(data.statuses![index].color ?? ""))*/,
          statusText: /*data.statuses![index].name ?? ""*/
              statusTextsList[index],
          statusNumber: Consumer<HomeProvider>(builder: (_, provider, child) {
            return ResponseBuilder(
              response: provider.allStatus,
              onComplete: (_, data, message) {
                String? mailCount = getCurrentMailCount(data, index);

                return Text(
                  "${/*data.statuses![index].mailsCount*/ mailCount}",
                  style: kStatusNumberTextStyle,
                );
              },
              onLoading: (_) {
                return const CustomShimmer(
                  child: Text(
                    "5",
                    style: kStatusNumberTextStyle,
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }

  String? getCurrentMailCount(StatusResponse data, int index) {
    return data.statuses
        ?.singleWhere((status) =>
            status.name?.toLowerCase() == statusTextsList[index].toLowerCase())
        .mailsCount;
  }
}
