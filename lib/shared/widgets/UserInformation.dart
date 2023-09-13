import 'package:flutter/material.dart';

import '../../core/util/colors.dart';
import '../../core/util/styles.dart';

class UserInformationDialog extends StatelessWidget {
  const UserInformationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.white,
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.all(28.0),
        width: deviceSize.width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("assets/images/palestine_bird.png"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Zaki Abu",
                  style: tagTitleTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "admin",
                  style: textInUserInformation,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            const Divider(
              color: kSubText,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 16,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.language),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Arabic",
                      style: textInUserInformation,
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Log out",
                      style: textInUserInformation,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
