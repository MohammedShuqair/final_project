import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class ChipClass extends StatelessWidget {
  final String tagTitle;

  const ChipClass({Key? key, required this.tagTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        tagTitle,
        style: textInTagTextStyle,
      ),
      backgroundColor: kUnselect,
    );
  }
}
