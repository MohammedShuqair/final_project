import 'package:final_project/app_views/new_inbox/views/widgets/sender_category_card.dart';
import 'package:final_project/app_views/new_inbox/views/widgets/title_description_card.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ],
      ),
    ));
  }
}
