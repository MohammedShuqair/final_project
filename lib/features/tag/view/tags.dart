import 'package:final_project/core/util/styles.dart';
import 'package:final_project/shared/widgets/core_background.dart';
import 'package:flutter/material.dart';

import 'chip_class.dart';

class Tags extends StatefulWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  bool isLoading = true;

  void getData() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tags",
          style: tagTitleTextStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        Core(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? Wrap( //Shimmer
            spacing: 8,
            runSpacing: 4, //here is question
            children: List.generate(
              4,
                  (index) => const ChipClass(tagTitle: "shimmer"),
            ),
          )
              : Wrap(
            spacing: 8,
            runSpacing: 4, //here is question
            children: List.generate( //here put children of widgets from api
              9,
                  (index) => const ChipClass(tagTitle: "tag Title"),
            ),
          ),
        ),
      ],
    );
  }
}

