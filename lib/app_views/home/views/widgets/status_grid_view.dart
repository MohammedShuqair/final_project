import 'dart:ffi';

import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/app_views/home/views/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:provider/provider.dart';

import '../../../../features/status/provider/status_provider.dart';
import '../../../shared/core_background.dart';
import 'chip_tag_widget.dart';

class StatusGridView extends StatefulWidget {
  const StatusGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatusGridView> createState() => _StatusGridViewState();
}

class _StatusGridViewState extends State<StatusGridView> {


  late bool isLoading = true; //for shimmer


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Consumer<StatusProvider>(builder: (_, provider, child) {
      return ResponseBuilder(
          response: provider.allStatus,
          onComplete: (_, data, message) {
            return SizedBox(
              height: deviceSize.height * 0.4,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio:
                      deviceSize.width > 400 ? 1.5 / 0.5 : 1.5 / 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return StatusWidget(
                    statusColor: Color(
                        int.parse(data!.statuses![index]!.color ?? "")),
                    statusText: data!.statuses![index]!.name ?? "",
                    statusNumber: data!.statuses!.isEmpty
                        ? Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: kUnselect,
                              shape: BoxShape.circle,
                            ),
                          )
                        : Text(
                            "${data.statuses![index].mailsCount}",
                            style: kStatusNumberTextStyle,
                          ),
                  );
                },
              ),
            );
          });
    });
  }
}
