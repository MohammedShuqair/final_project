import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class MailsShimmer extends StatelessWidget {
  const MailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return CustomShimmer(
          highlightColor: Colors.black,
          child: ExpansionWidget(
            title: defaultCategories[index].name ?? lorem(words: 1),
            cards: const [],
          ),
        );
      },
      separatorBuilder: (_, index) {
        return const SSizedBox(
          height: 14,
        );
      },
      itemCount: defaultCategories.length,
    );
  }
}
