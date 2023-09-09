import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusTile extends StatefulWidget {
  const StatusTile({super.key});

  @override
  State<StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/indox.svg',
            width: 19.0.w,
            height: 14.0.h,
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsetsDirectional.only(start: 18.w, end: 10.w),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    'Inbox',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
          ),
          SvgPicture.asset(
            'assets/icons/arrow_gray.svg',
            width: 18.0,
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
