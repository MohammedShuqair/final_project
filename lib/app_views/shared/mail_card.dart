import "package:final_project/app_views/home/views/widgets/chip_tag_widget.dart";
import "package:final_project/app_views/shared/core_background.dart";
import "package:final_project/features/tag/models/tag.dart";
import "package:flutter/material.dart";

import "../../../core/util/colors.dart";
import "../../../core/util/styles.dart";

const String imageUrl = "https://palmail.gsgtt.tech/storage/";

class MailCard extends StatelessWidget {
  const MailCard(
      {Key? key,
      required this.organizationName,
      required this.lastDate,
      required this.subject,
      required this.body,
      required this.tags,
      required this.images})
      : super(key: key);
  final String organizationName;
  final String lastDate;
  final String subject;
  final String body;
  final List<String> tags;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Core(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Row1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.yellowAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Text(
                    organizationName,
                    style: kTitleMailCard,
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        lastDate.substring(0, 10),
                        style: kSearchText,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_right_outlined),
                      color: kSubText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 24),
            constraints: BoxConstraints(
              maxWidth: deviceSize.width * 0.7,
            ),
            child: Text(
              subject,
              style: kSubTitleMailCard,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24),
            constraints: BoxConstraints(
              maxWidth: deviceSize.width * 0.7,
            ),
            child: Text(
              body,
              style: kSubSubTitleMailCard,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24),
            child: Wrap(
                spacing: 16,
                children: tags
                    .map((e) => ChipWidget(
                          tagTitle: e,
                        ))
                    .toList() /*[
                Chip(
                  label: Text(
                    "#zaki",
                    style: kSubSubTagTitleMailCard,
                  ),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text(
                    "#zaki",
                    style: kSubSubTagTitleMailCard,
                  ),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  label: Text(
                    "#zaki",
                    style: kSubSubTagTitleMailCard,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],*/
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Wrap(
                spacing: 16,
                children: images
                    .map(
                      (e) => Image.network(
                        imageUrl + e,
                        fit: BoxFit.fill,
                        width: 36,
                        height: 36,
                        errorBuilder: (_, __, ___) {
                          return SizedBox();
                        },
                      ),
                    )
                    .toList() /*[
                Image.asset(
                  "assets/images/palestine_bird.png",
                  width: 36,
                  height: 36,
                ),
                Image.asset(
                  "assets/images/palestine_bird.png",
                  width: 36,
                  height: 36,
                ),
              ],*/
                ),
          ),
        ],
      ),
    );
  }
}
