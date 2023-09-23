import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.hint,
    required this.onTap,
    this.color,
  });

  final String hint;
  final void Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          hint,
          style: kStatusNameTextStyle.copyWith(color: color ?? kLightSub),
        ));
  }
}
