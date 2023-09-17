import 'package:final_project/app_views/mail_details/views/widgets/sender_date_title_descreption.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MailDetailsView extends StatelessWidget {
  const MailDetailsView({Key? key, required this.mail}) : super(key: key);
  static const String id = '/mailDetailsView';
  final Mail mail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 14.sp,
              color: kDarkSub,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: kLightSub,
              ))
        ],
      ),
      body: ListView(
        children: [
          SenderDataTitleDescreption(),
        ],
      ),
    );
  }
}
