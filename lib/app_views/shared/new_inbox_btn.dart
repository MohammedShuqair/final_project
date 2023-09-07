import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class InBoxButton extends StatelessWidget {
  const InBoxButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                color: kLightSub,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                weight: 600,
              ),
            ),
          ),
          const SSizedBox(
            width: 16,
          ),
          const Text(
            "New Inbox",
            style: kInBoxButtonTextStyle,
          ),
        ],
      ),
    );
  }
}
