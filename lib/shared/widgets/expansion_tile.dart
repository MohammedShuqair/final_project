import 'package:flutter/material.dart';

import '../../core/util/colors.dart';
import '../../core/util/styles.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({Key? key}) : super(key: key);
  //here pass title and number

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  //receive title text, number of children, children :list of widget

  bool isClose = true;

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() {
    //get on children
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpansionTile(
          // how to animation
          shape: Border.all(color: Colors.transparent),
          onExpansionChanged: (_) {
            setState(() {
              isClose = !isClose;
            });
          },
          title: const Text(
            'Tile 1',
            style: tagTitleTextStyle,
          ),
          trailing: isClose
              ? const Row(
                  //Question in design
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "2",
                      style: kNumArrowInExpansion,
                    ),
                    Icon(
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
          children: const <Widget>[
            ListTile(
              title: Text('stile 1'),
            ),
            ListTile(
              title: Text('stile 2'),
            ),
          ], //here pass children
        ),
      ],
    );
  }
}
