import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SenderCategoryCard extends StatelessWidget {
  const SenderCategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Core(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: deviceSize.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD0D0D0),),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD0D0D0),),
                    ),
                    hintStyle: kHintSimi16AF,
                    hintText: "Sender",
                    prefixIcon: const Icon(Icons.person_2_outlined, color: Color(0xFF707070),),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        color: kLightSub,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
           SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                "Category",
                style: kHintNormal16Dark,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    "Other",
                    style: kNormal14Color7c,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: kSubText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//styles

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
