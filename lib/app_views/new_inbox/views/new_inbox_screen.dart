import 'package:final_project/app_views/new_inbox/views/widgets/sender_category_card.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/title_description_card.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/activity_card.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/send_activity_bar.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/tag_tile.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/tag/models/tag.dart';

class NewInbox extends StatelessWidget {
  const NewInbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      child: Column(
        children: [
          SheetBar(
            onTapDone: () {
              Navigator.pop(context, {});
            },
            hint: 'Filters',
          ),
          const SSizedBox(
            height: 17,
          ),
          const SenderMobileCategoryCard(),
          const TitleDescriptionCard(),
          /*kHintSimi20AF
              kHintNormal14AF*/
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
    ));
  }
}
