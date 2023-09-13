import 'dart:core';
import 'package:flutter/material.dart';

import 'package:final_project/core/util/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/util/colors.dart';

class StatusSheet extends StatelessWidget {
  StatusSheet({Key? key}) : super(key: key);

  final List<Color> colors = [
    kInbox,
    kPending,
    kLightSub,
    kCompleted,

  ];
  final List<String> statusNames = [
    "Inbox",
    "Pending",
    "In Progress",
    "Completed",
  ];

  @override
  Widget build(BuildContext context) {
    print("enter");
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
          height: 56.h,
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            bottom: 20,


          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Status", style: kAddStatus16RegLightBlue,),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 18.w,
                    height: 18.h,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: kLightGrey,),
                    ),
                  ),
                  SizedBox(height: 22.h,),
                ],
              ),
              SizedBox(height: 24.h,),
              ListView.separated(itemBuilder: (_, index,) {
                return Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors[index], //
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    Text(statusNames[index], style: kStatusNameTextStyle,),
                  ],
                );
              }, separatorBuilder: (_, index) {
                return const Divider(
                  color: Color(0xFFD0D0D0),
                  thickness: 1.0,
                );
              }, itemCount: 2)

            ],
          ),
        )
      ],
    );
  }
}