import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/app_views/shared/status_list.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class StatusListShimmer extends StatelessWidget {
  const StatusListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: StatusList(
        statuses: List.generate(
            defaultStatues.length,
            (index) => Status(
                name: defaultStatues[index].name?.tr() ?? lorem(words: 1),
                color: defaultStatues[index].color ?? '')),
        onTap: (s) {},
      ),
    );
  }
}
