import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/activity_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/send_activity_bar.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_tile.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:flutter/material.dart';

class NewInbox extends StatelessWidget {
  const NewInbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TagTiles(
              tags: [
                Tag(id: 1, name: "Gaza"),
                Tag(id: 2, name: "Khan"),
                Tag(id: 3, name: "Mo"),
              ],
            ),
            ActivityCard(
              activity: Activity(
                  id: 1,
                  sendDate: DateTime.now().toString(),
                  body: "This is Body",
                  user: User(
                      id: 1,
                      name: "Name",
                      image: "assets/images/palestine_bird.png")),
            ),
            SendActivityBar(
              onSubmitted: (String value) {
                print(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
