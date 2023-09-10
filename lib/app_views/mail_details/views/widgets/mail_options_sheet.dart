import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MailOptionsSheet extends StatefulWidget {
  static const String id = '/mailOptions';
  const MailOptionsSheet({super.key});

  @override
  State<MailOptionsSheet> createState() => _MailOptionsSheetState();
}

class _MailOptionsSheetState extends State<MailOptionsSheet> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
        decoration: const BoxDecoration(
            color: kBackground,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              children: [
                Text('Title of Mail',
                    style: TextStyle(
                        color: kDarkText,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/exit.svg',
                  width: 24.0.w,
                  height: 24.0.h,
                ),
              ],
            ),
            SizedBox(
              height: 34,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 30,bottom: 18),

                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/archive.svg',
                          width: 24.0.w,
                          height: 24.0.h,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('Archive',
                            style: TextStyle(
                                color: kText,
                                fontSize: 14,)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 14,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 30,bottom: 18),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/share.svg',
                          width: 24.0.w,
                          height: 24.0.h,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('Share',
                            style: TextStyle(
                                color: kShareText,
                                fontSize: 14,)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 14,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 30,bottom: 18),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/delete.svg',
                          width: 24.0.w,
                          height: 24.0.h,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('Delete',
                            style: TextStyle(
                                color: kDeleteText,
                                fontSize: 14,)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
