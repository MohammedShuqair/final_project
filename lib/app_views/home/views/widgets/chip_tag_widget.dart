import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../core/util/colors.dart';

class ChipWidget extends StatelessWidget {
  final String? tagTitle;
  final bool isShimmer;
  const ChipWidget({Key? key, required this.tagTitle, this.isShimmer = false})
      : super(key: key);
  const ChipWidget.shimmer({Key? key, this.tagTitle, this.isShimmer = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 19),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: /*isShimmer ? null : */ kUnselect,
        borderRadius: BorderRadius.circular(15),
      ),
      child: isShimmer
          ? CustomShimmer(
              highlightColor: kText,
              child: Text(
                lorem(words: 1),
                style: textInTagTextStyle,
              ),
            )
          : Text(
              tagTitle!,
              style: textInTagTextStyle,
            ),
    );
  }
}
