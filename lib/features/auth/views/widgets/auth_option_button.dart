import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class AuthOption extends StatelessWidget {
  const AuthOption({
    super.key,
    required this.selectFactor,
    required this.label,
  });

  final bool selectFactor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        /*decoration: selectFactor
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: kDarkSub)
            : null,*/
        child: Text(
          label,
          style: selectFactor ? kSelectedButton : kUnSelectedButton,
        ));
  }
}
