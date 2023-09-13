import 'package:final_project/app_views/shared/core_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/util/colors.dart';
import '../../core/util/styles.dart';

class TagSheet extends StatefulWidget {
  TagSheet({Key? key}) : super(key: key);

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> {
  List<String> listOfTags = ["tag", "new", "tiger"];

  TextEditingController tagControllerTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                "cancel",
                style: kCancel18RegLightBlue,
              ),
            ),
            Text(
              "Status",
              style: kStatusWord18SimiDark,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Done",
                style: kDone18SimiLightBlue,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 57.h,
        ),
        Core(
            child: Wrap(
          children: [
            ...List.generate(
              listOfTags.length,
              (index) => GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: kUnselect,
                  ),
                  child: Text(
                    listOfTags[index],
                    style: textInTagTextStyle,
                  ),
                ),
              ),
            ),
          ],
        )),
        SizedBox(
          height: 12.h,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),
          child: TextField(
            controller: tagControllerTextField,
            keyboardType: TextInputType.name,
            decoration: InputDecoration.collapsed(
              hintText: "Add New Tag...",
              hintStyle: kHintTextInTagTextField,
            ),
          ),
        )
      ],
    );
  }
}
