import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/image_tile.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:flutter/material.dart';

class PickImageView extends StatelessWidget {
  const PickImageView(
      {Key? key,
      required this.images,
      required this.onTapAddImage,
      required this.onTapDelete})
      : super(key: key);
  final List<Attachment> images;
  final void Function() onTapAddImage;
  final void Function(String path) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Core(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (getUser().role?.id == adminId) ...[
          InkWell(
            onTap: onTapAddImage,
            child: Text(
              context.tr("add_image"),
              style: kAddStatus16RegLightBlue,
            ),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16, bottom: 10, top: 10),
            child: Text(
              'Images',
              style: tagTitleTextStyle,
            ),
          )
        ],
        if (images.isNotEmpty) ...[
          const SSizedBox(
            height: 10,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) => ImageTile(
                    image: images[index].id != null
                        ? images[index].image != null &&
                                images[index].image!.isNotEmpty
                            ? '$imageUrl${images[index].image}'
                            : ''
                        : images[index].image ?? '',
                    fromNetwork: images[index].id != null,
                    onTapDelete: () {
                      onTapDelete(images[index].image ?? '');
                    },
                  ),
              separatorBuilder: (_, index) => const Divider(),
              itemCount: images.length),
        ]
      ],
    ));
  }
}
