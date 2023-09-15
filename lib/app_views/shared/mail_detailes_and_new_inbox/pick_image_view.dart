import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/app_views/shared/mail_image.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class PickImageView extends StatelessWidget {
  const PickImageView(
      {Key? key,
      required this.images,
      required this.onTapAddImage,
      this.fromNetwork = true,
      required this.onTapDelete})
      : super(key: key);
  final List<String> images;
  final bool fromNetwork;
  final void Function() onTapAddImage;
  final void Function(String path) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Core(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTapAddImage,
          child: Text(
            "Add New Image",
            style: kAddStatus16RegLightBlue,
          ),
        ),
        if (images.isNotEmpty) ...[
          const SSizedBox(
            height: 10,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) => ImageTile(
                    image: images[index],
                    fromNetwork: fromNetwork,
                    onTapDelete: () {
                      onTapDelete(images[index]);
                    },
                  ),
              separatorBuilder: (_, index) => const Divider(),
              itemCount: images.length),
        ]
      ],
    ));
  }
}

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
        TextButton(onPressed: onTapDelete, child: Text("Delete"))
      ],
    );
  }
}
