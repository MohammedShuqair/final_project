import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/mail_image.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.image,
    required this.fromNetwork,
    required this.onTapDelete,
  });

  final String image;
  final bool fromNetwork;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MailImage(
          path: image,
          fromNetwork: fromNetwork,
        ),
        TextButton(onPressed: onTapDelete, child: Text("Delete".tr()))
      ],
    );
  }
}
