import 'package:final_project/core/util/edited_expansion_tile.dart' as ed;
import 'package:flutter/material.dart';
import 'package:final_project/core/util/extensions.dart';
import '../../core/util/colors.dart';
import '../../core/util/styles.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget(
      {Key? key, required this.title, required this.mailsCards})
      : super(key: key);
  final String title;
  final List<Widget> mailsCards;

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  bool isClose = true;

  @override
  Widget build(BuildContext context) {
    return ed.ExpansionTile(
        tilePadding: EdgeInsets.zero,
        shape: Border.all(color: Colors.transparent),
        onExpansionChanged: (_) {
          setState(() {
            isClose = !isClose;
          });
        },
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(
            widget.title.firstCapital(),
            style: tagTitleTextStyle,
          ),
        ),
        trailing: isClose
            ? Row(
                //Question in design
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.mailsCards.length}',
                    style: kNumArrowInExpansion,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: kSubText,
                  ),
                ],
              )
            : const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: kLightSub,
                size: 24,
              ),
        children: widget.mailsCards //here pass children
        );
  }
}
