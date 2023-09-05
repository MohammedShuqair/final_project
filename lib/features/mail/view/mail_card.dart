import "package:flutter/material.dart";

import "../../../core/util/colors.dart";
import "../../../core/util/styles.dart";
import "../../../shared/widgets/core_background.dart";

class MailCard extends StatelessWidget {
  const MailCard({Key? key}) : super(key: key);

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
                  const Text(
                    "Organization Name",
                    style: kTitleMailCard,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Today, 11:00 AM",
                    style: kSearchText,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_right_outlined),
                    color: kSubText,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 24),
            constraints: BoxConstraints(
              maxWidth: deviceSize.width * 0.7,
            ),
            child: const Text(
              "Here we add the subject",
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
            child: const Text(
              "And here excerpt of the mail, can added to this location. And we can do more to this like …",
              style: kSubSubTitleMailCard,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Wrap(
              spacing: 16,
              children: [
                Chip(
                  label: Text("#zaki", style: kSubSubTagTitleMailCard,),
                  backgroundColor: Colors.white,

                ),
                Chip(
                  label: Text("#zaki", style: kSubSubTagTitleMailCard,),
                  backgroundColor: Colors.white,

                ),
                Chip(
                  label: Text("#zaki", style: kSubSubTagTitleMailCard,),
                  backgroundColor: Colors.white,

                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Wrap(
              spacing: 16,
              children: [
                Image.asset("assets/images/palestine_bird.png", width: 36, height: 36,),
                Image.asset("assets/images/palestine_bird.png", width: 36, height: 36,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
