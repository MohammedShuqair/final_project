import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class SheetBar extends StatelessWidget {
  const SheetBar({
    super.key,
    required this.onTapDone,
    required this.hint,
  });
  final String hint;
  final void Function() onTapDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionButton(
          hint: context.tr('cancel'),
          onTap: () {
            Navigator.pop(context, {});
          },
        ),
        Text(
          hint,
          style: kTitleMailCard,
        ),
        ActionButton(
          hint: context.tr('done'),
          onTap: onTapDone,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.hint,
    required this.onTap,
  });

  final String hint;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          hint,
          style: kStatusNameTextStyle.copyWith(color: kLightSub),
        ));
  }
}
