import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/action_button.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class SheetBar extends StatelessWidget {
  const SheetBar({
    super.key,
    required this.onTapDone,
    this.hint,
  });
  final String? hint;
  final void Function() onTapDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionButton(
          hint: context.tr('cancel'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        if (hint != null)
          Text(
            hint!,
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
