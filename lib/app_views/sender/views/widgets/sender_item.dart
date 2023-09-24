import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SenderItem extends StatelessWidget {
  const SenderItem({
    Key? key,
    required this.sender,
    this.onTapDelete,
    this.onTapEdit,
  }) : super(key: key);
  final Sender sender;
  final void Function()? onTapDelete;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: SvgPicture.asset('assets/icons/sender.svg'),
      title: Text(
        sender.name?.firstCapital() ?? 'Name',
        style: kSubTitleMailCard,
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.phone,
            color: kSubText,
            size: 12,
          ),
          const SSizedBox(
            width: 4,
          ),
          Text(
            sender.mobile ?? 'mobile number',
            style: kSearchText,
          )
        ],
      ),
      trailing: onTapDelete == null && onTapEdit == null
          ? null
          : PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: onTapDelete,
                      child: Text('Delete'.tr()),
                    ),
                    PopupMenuItem(
                      onTap: onTapEdit,
                      child: Text(context.tr('Edit')),
                    ),
                  ]),
    );
  }
}
