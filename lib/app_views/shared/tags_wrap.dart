import 'package:final_project/app_views/home/views/widgets/chip_tag_widget.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/util/extensions.dart';

class TagWrap extends StatelessWidget {
  const TagWrap({
    super.key,
    required this.onTap,
    required this.tags,
    required this.selectedTags,
    this.leading = false,
  });
  final void Function(Tag tag) onTap;
  final Set<Tag> tags;
  final Set<Tag> selectedTags;
  final bool leading;
  @override
  Widget build(BuildContext context) {
    if (tags.isNotEmpty) {
      return Wrap(
        spacing: 8,
        runSpacing: 8, //here is question
        children: List.generate(
          tags.length,
          (index) => GestureDetector(
            onTap: () => onTap(tags.elementAt(index)),
            child: ChipWidget(
              tagTitle:
                  '${leading ? "#" : ''}${tags.elementAt(index).name?.firstCapital()}',
              isSelected: selectedTags
                  .map((e) => e.id)
                  .toList()
                  .contains(tags.elementAt(index).id),
            ),
          ),
        ),
      );
    } else {
      return Text(
        "No Tags Found",
        style: kTitleMailCard,
      );
    }
  }
}
