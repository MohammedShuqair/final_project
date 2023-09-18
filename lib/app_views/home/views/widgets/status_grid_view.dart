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
    "inbox",
    "pending",
    "In Progress",
    "completed"
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: StatusWidget(
              statusColor: statusColorsList[0],
              statusText: statusTextsList[0],
              statusNumber: Consumer<HomeProvider>(builder: (_, provider, child) {
                return ResponseBuilder(
                  response: provider.allStatus,
                  onComplete: (_, data, message) {
                    String? mailCount = getCurrentMailCount(data, 0);

                    return Text(
                      "${/*data.statuses![index].mailsCount*/ mailCount}",
                      style: kStatusNumberTextStyle,
                    );
                  },
                  onLoading: (_) {
                    return CustomShimmer(
                      child: Text(
                        "5",
                        style: kStatusNumberTextStyle,
                      ),
                    );
                  },
                );
              }),
            )),
            SizedBox(width: 16.0),
            Expanded(child: StatusWidget(
              statusColor: statusColorsList[1],
              statusText: statusTextsList[1],
              statusNumber: Consumer<HomeProvider>(builder: (_, provider, child) {
                return ResponseBuilder(
                  response: provider.allStatus,
                  onComplete: (_, data, message) {
                    String? mailCount = getCurrentMailCount(data, 1);

                    return Text(
                      "${/*data.statuses![index].mailsCount*/ mailCount}",
                      style: kStatusNumberTextStyle,
                    );
                  },
                  onLoading: (_) {
                    return CustomShimmer(
                      child: Text(
                        "5",
                        style: kStatusNumberTextStyle,
                      ),
                    );
                  },
                );
              }),
            )),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(child: StatusWidget(
              statusColor: statusColorsList[2],
              statusText: statusTextsList[2],
              statusNumber: Consumer<HomeProvider>(builder: (_, provider, child) {
                return ResponseBuilder(
                  response: provider.allStatus,
                  onComplete: (_, data, message) {
                    String? mailCount = getCurrentMailCount(data, 2);

                    return Text(
                      "${/*data.statuses![index].mailsCount*/ mailCount}",
                      style: kStatusNumberTextStyle,
                    );
                  },
                  onLoading: (_) {
                    return CustomShimmer(
                      child: Text(
                        "5",
                        style: kStatusNumberTextStyle,
                      ),
                    );
                  },
                );
              }),
            )),
            SizedBox(width: 16.0),
            Expanded(child: StatusWidget(
              statusColor: statusColorsList[3],
              statusText: statusTextsList[3],
              statusNumber: Consumer<HomeProvider>(builder: (_, provider, child) {
                return ResponseBuilder(
                  response: provider.allStatus,
                  onComplete: (_, data, message) {
                    String? mailCount = getCurrentMailCount(data, 3);

                    return Text(
                      "${/*data.statuses![index].mailsCount*/ mailCount}",
                      style: kStatusNumberTextStyle,
                    );
                  },
                  onLoading: (_) {
                    return CustomShimmer(
                      child: Text(
                        "5",
                        style: kStatusNumberTextStyle,
                      ),
                    );
                  },
                );
              }),
            )),
          ],
        ),
      ],
    );
  }

  String? getCurrentMailCount(StatusResponse data, int index) {
    return data.statuses
        ?.singleWhere((status) =>
    status.name?.toLowerCase() == statusTextsList[index].toLowerCase())
        .mailsCount;
  }
}