import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle kLogo = TextStyle(fontSize: 31.sp, color: kWhite);
TextStyle kF16N = TextStyle(fontSize: 18.sp, color: kWhite);

TextStyle kSelectedButton =
    TextStyle(fontSize: 14.sp, color: kWhite, fontWeight: FontWeight.w600);
TextStyle kUnSelectedButton = TextStyle(fontSize: 14.sp, color: kDarkSub);

//zaki TextStyles

//status
TextStyle kStatusNumberTextStyle =
    TextStyle(color: kDarkText, fontSize: 20.sp, fontWeight: FontWeight.w600);
TextStyle kStatusNameTextStyle =
    TextStyle(color: kSubText, fontSize: 18.sp, fontWeight: FontWeight.w600);

//Tags Widgets
TextStyle tagTitleTextStyle = TextStyle(
    color: kDarkText,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600); // also for title in expansion
TextStyle textInTagTextStyle =
    TextStyle(color: kText, fontSize: 14.sp, fontWeight: FontWeight.w600);
TextStyle kF14N =
    TextStyle(color: kText, fontSize: 14.sp, fontWeight: FontWeight.normal);

//inbox button
TextStyle kInBoxButtonTextStyle =
    TextStyle(color: kLightSub, fontSize: 20.sp, fontWeight: FontWeight.w600);

//Expansion tile
TextStyle kNumArrowInExpansion =
    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: kSubText);

//search
TextStyle kSearchText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: kSubText); //font weight

//mail Card

const TextStyle textInUserInformation =
    TextStyle(color: kText, fontSize: 18, fontWeight: FontWeight.w600);

TextStyle kTitleMailCard =
    TextStyle(color: kDarkText, fontSize: 18.sp, fontWeight: FontWeight.w600);
TextStyle kSubTitleMailCard =
    TextStyle(color: kDarkText, fontSize: 14.sp, fontWeight: FontWeight.normal);
TextStyle kSubSubTitleMailCard =
    TextStyle(color: kLightSub, fontSize: 14.sp, fontWeight: FontWeight.normal);
TextStyle kSubSubTagTitleMailCard =
    TextStyle(color: kLightSub, fontSize: 14.sp, fontWeight: FontWeight.w600);

//status sheet and tag sheet
TextStyle kCancel18RegLightBlue =
    TextStyle(color: kLightSub, fontSize: 18.sp, fontWeight: FontWeight.normal);

TextStyle kStatusWord18SimiDark =
    TextStyle(color: kDarkText, fontSize: 18.sp, fontWeight: FontWeight.w600);

TextStyle kDone18SimiLightBlue =
    TextStyle(color: kLightSub, fontSize: 18.sp, fontWeight: FontWeight.w600);

TextStyle kAddStatus16RegLightBlue =
    TextStyle(color: kLightSub, fontSize: 16.sp, fontWeight: FontWeight.normal);

TextStyle kStatusName16RegDark =
    TextStyle(color: kDarkText, fontSize: 16.sp, fontWeight: FontWeight.normal);

TextStyle kHintTextInTagTextField = TextStyle(
    color: kLightGrey2, fontSize: 14.sp, fontWeight: FontWeight.normal);

//styles
TextStyle kHintSimi20AF = TextStyle(
    color: const Color(0xFFAFAFAF),
    fontSize: 20.sp,
    fontWeight: FontWeight.w600);
TextStyle kHintNormal14AF = TextStyle(
    color: const Color(0xFFAFAFAF),
    fontSize: 14.sp,
    fontWeight: FontWeight.normal);
TextStyle kHintSimi16AF = TextStyle(
    color: const Color(0xFFAFAFAF),
    fontSize: 16.sp,
    fontWeight: FontWeight.w600);
TextStyle kHintNormal16Dark =
    TextStyle(color: kDarkText, fontSize: 16.sp, fontWeight: FontWeight.normal);
TextStyle kNormal14Color7c = TextStyle(
    color: const Color(0xFF7C7C7C),
    fontSize: 14.sp,
    fontWeight: FontWeight.normal);
TextStyle kSimi14Blue =
    TextStyle(color: kLightSub, fontSize: 14.sp, fontWeight: FontWeight.w600);
