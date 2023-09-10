import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MailDetailsScreen extends StatefulWidget {
  static const String id = "/mailDetailsScreen";

  const MailDetailsScreen({super.key});

  @override
  State<MailDetailsScreen> createState() => _MailDetailsScreenState();
}

class _MailDetailsScreenState extends State<MailDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Container(
              height: 218,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        width: 16.0.w,
                        height: 15.0.h,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Sport Ministry',
                          style: TextStyle(
                              color: kDarkText,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('Today, 11:00 AM',
                          style: TextStyle(
                              color: kSubText,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Official organization',
                          style: TextStyle(color: kSubText, fontSize: 12),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Arch 2022/1032',
                        style: TextStyle(color: kSubText, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Divider(color: kLine),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text('Title of mail',
                          style: TextStyle(
                              color: kDarkText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/arrow_down.svg',
                        width: 18.0.w,
                        height: 12.0.h,
                      ),
                    ],
                  ),
                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      style: TextStyle(
                          color: kTag,
                          fontSize: 14,),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Container(
              height: 110,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Decision',
                      style: TextStyle(
                          color: kDarkText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 2,),
                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has ',
                      style: TextStyle(
                          color: kDarkText,
                          fontSize: 14,),
                  maxLines: 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
