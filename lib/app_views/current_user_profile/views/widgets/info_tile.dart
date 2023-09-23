import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.hint,
    required this.info,
  });
  final String hint;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          hint,
          style: k14Seme.copyWith(color: kText),
        ),
        const SSizedBox(
          width: 4,
        ),
        Text(
          info,
          style: k14Seme,
        ),
      ],
    );
  }
}
