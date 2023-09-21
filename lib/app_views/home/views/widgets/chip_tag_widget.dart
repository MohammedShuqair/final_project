import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../core/util/colors.dart';

class ChipWidget extends StatelessWidget {
  final String? tagTitle;
  final bool isSelected;
  final bool isShimmer;
  const ChipWidget(
      {Key? key,
      required this.tagTitle,
      this.isShimmer = false,
      required this.isSelected})
      : super(key: key);
  const ChipWidget.shimmer(
      {Key? key, this.tagTitle, this.isShimmer = true, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 19),
      decoration: BoxDecoration(
        color: /*isShimmer ? null : */ isSelected ? kLightSub : kUnselect,
        borderRadius: BorderRadius.circular(15),
      ),
      child: isShimmer
          ? CustomShimmer(
              highlightColor: kText,
              child: Text(
                lorem(words: 1),
                style: isSelected
                    ? textInTagTextStyle.copyWith(color: Colors.white)
                    : textInTagTextStyle,
              ),
            )
          : Text(
              tagTitle!,
              style: isSelected
                  ? textInTagTextStyle.copyWith(color: Colors.white)
                  : textInTagTextStyle,
            ),
    );
  }
}
