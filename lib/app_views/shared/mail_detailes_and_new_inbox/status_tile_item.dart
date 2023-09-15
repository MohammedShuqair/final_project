import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusTileItem extends StatelessWidget {
  const StatusTileItem({
    super.key,
    required this.status,
  });
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: Color(int.tryParse(status.color ?? '0xFFB2B2B2')!),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Text(
        status.name ?? '',
        style: kSelectedButton,
      ),
    );
  }
}
