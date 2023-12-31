import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/widgets/status_view.dart';
import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/home/views/widgets/status_widget.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:provider/provider.dart';

class StatusGridView extends StatelessWidget {
  const StatusGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, StatusMailsView.id,
                    arguments: defaultStatues[0]);
              },
              child: StatusWidget(
                statusColor: Color(int.tryParse(defaultStatues[0].color!)!),
                statusText: context.tr(defaultStatues[0].name!),
                statusNumber:
                    Consumer<HomeProvider>(builder: (_, provider, child) {
                  return ResponseBuilder(
                    response: provider.allStatus,
                    onComplete: (_, data, message, more) {
                      String? mailCount = getCurrentMailCount(data, 0);
                      if (more) {
                        return CustomShimmer(
                          child: Text(
                           '$mailCount',
                            style: kStatusNumberTextStyle,
                          ),
                        );
                      }
                      return Text(
                        "$mailCount",
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
              ),
            )),
            const SSizedBox(width: 16.0),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, StatusMailsView.id,
                    arguments: defaultStatues[1]);
              },
              child: StatusWidget(
                statusColor: Color(int.tryParse(defaultStatues[1].color!)!),
                statusText: context.tr(defaultStatues[1].name!),
                statusNumber:
                    Consumer<HomeProvider>(builder: (_, provider, child) {
                  return ResponseBuilder(
                    response: provider.allStatus,
                    onComplete: (_, data, message, more) {
                      String? mailCount = getCurrentMailCount(data, 1);
                      if (more) {
                        return CustomShimmer(
                          child: Text(
                            '$mailCount',
                            style: kStatusNumberTextStyle,
                          ),
                        );
                      }

                      return Text(
                        "$mailCount",
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
              ),
            )),
          ],
        ),
        const SSizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, StatusMailsView.id,
                    arguments: defaultStatues[2]);
              },
              child: StatusWidget(
                statusColor: Color(int.tryParse(defaultStatues[2].color!)!),
                statusText: context.tr(defaultStatues[2].name!),
                statusNumber:
                    Consumer<HomeProvider>(builder: (_, provider, child) {
                  return ResponseBuilder(
                    response: provider.allStatus,
                    onComplete: (_, data, message, more) {
                      String? mailCount = getCurrentMailCount(data, 2);
                      if (more) {
                        return CustomShimmer(
                          child: Text(
                            '$mailCount',
                            style: kStatusNumberTextStyle,
                          ),
                        );
                      }

                      return Text(
                        "$mailCount",
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
              ),
            )),
            const SSizedBox(width: 16.0),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, StatusMailsView.id,
                    arguments: defaultStatues[3]);
              },
              child: StatusWidget(
                statusColor: Color(int.tryParse(defaultStatues[3].color!)!),
                statusText: context.tr(defaultStatues[3].name!),
                statusNumber:
                    Consumer<HomeProvider>(builder: (_, provider, child) {
                  return ResponseBuilder(
                    response: provider.allStatus,
                    onComplete: (_, data, message, more) {
                      String? mailCount = getCurrentMailCount(data, 3);
                      if (more) {
                        return CustomShimmer(
                          child: Text(
                            '$mailCount',
                            style: kStatusNumberTextStyle,
                          ),
                        );
                      }

                      return Text(
                        "$mailCount",
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
              ),
            )),
          ],
        ),
      ],
    );
  }

  String? getCurrentMailCount(StatusResponse data, int index) {
    return data.statuses
        ?.singleWhere((status) => status.id == defaultStatues[index].id)
        .mailsCount;
  }
}
