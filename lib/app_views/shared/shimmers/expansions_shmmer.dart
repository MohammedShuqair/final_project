import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class ExpansionsShimmer extends StatelessWidget {
  const ExpansionsShimmer({
    super.key,
    required this.titles,
  });
  final List<String?> titles;

  @override
  Widget build(BuildContext context) {
    print(titles);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return CustomShimmer(
          highlightColor: Colors.black,
          child: ExpansionWidget(
            title: titles[index] ?? lorem(words: 1),
            cards: const [],
          ),
        );
      },
      separatorBuilder: (_, index) {
        return const SSizedBox(
          height: 14,
        );
      },
      itemCount: titles.length,
    );
  }
}
