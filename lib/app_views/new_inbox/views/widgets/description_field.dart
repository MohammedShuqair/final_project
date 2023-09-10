import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../../shared/core_background.dart";

class DescriptionField extends StatelessWidget {
  const DescriptionField({Key? key}) : super(key: key);

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
                    border:  const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD0D0D0),),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD0D0D0),),
                    ),
                    hintStyle: kHintSimi20AF,
                    hintText: "Title of mail",
                  ),
                ),
              ),
            ],
          ),
           SizedBox(
            height: 16.h,
          ),
          SizedBox(
            width: deviceSize.width * 0.8,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: kHintNormal14AF,
                hintText: "Description",
              ),
            ),
          ),

        ],
      ),
    );
  }
}


//styles
TextStyle kHintSimi20AF = TextStyle(
    color: const Color(0xFFAFAFAF), fontSize: 20.sp, fontWeight: FontWeight.w600);
TextStyle kHintNormal14AF = TextStyle(
    color: const Color(0xFFAFAFAF), fontSize: 14.sp, fontWeight: FontWeight.normal);

