import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class PickImageSheet extends StatelessWidget {
  const PickImageSheet({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });
  final void Function() onTapCamera;
  final void Function() onTapGallery;

  @override
  Widget build(BuildContext context) {
    return Core(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: onTapCamera,
              leading: const Icon(Icons.camera),
              title: Text(
                context.tr("From_Camera"),
                style: kStatusName16RegDark,
              ),
            ),
            ListTile(
              onTap: onTapGallery,
              leading: const Icon(Icons.image),
              title: Text(
                context.tr("From_Gallery"),
                style: kStatusName16RegDark,
              ),
            ),
          ],
        ));
  }
}
