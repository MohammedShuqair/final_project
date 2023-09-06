import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/colors.dart';


class ChipWidget extends StatelessWidget {
  final String tagTitle;

  const ChipWidget({Key? key, required this.tagTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 19),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kUnselect,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(tagTitle, style: textInTagTextStyle,),

    );
  }
}

