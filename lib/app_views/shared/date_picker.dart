import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
// import 'package:final_project/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker(
      {Key? key,
      required this.selectedDate,
      required this.onChangeDate,
      this.hint = 'Date'})
      : super(key: key);
  final DateTime selectedDate;
  final void Function(DateTime newDate) onChangeDate;
  final String hint;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  bool isClose = true;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsetsDirectional.only(end: 16.w),
      shape: Border.all(color: Colors.transparent),
      onExpansionChanged: (_) {
        setState(() {
          isClose = !isClose;
        });
      },
      title: Row(
        children: [
          const Icon(
            Icons.date_range,
            color: Color(0xffD62929),
          ),
          const SSizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(widget.hint),
                  style: kStatusName16RegDark,
                ),
                // ${DateFormat.yMMMMd().format(selectedDate)}
                Text(
                  DateFormat('EEEE, MMMM d, y').format(widget.selectedDate),
                  style: kSubSubTitleMailCard.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          )
        ],
      ),
      trailing: isClose
          ? const Icon(
              Icons.arrow_forward_ios,
              size: 19,
              color: kSubText,
            )
          : const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: kLightSub,
              size: 24,
            ),
      children: [
        CalendarDatePicker(
          initialDate: widget.selectedDate,
          firstDate: DateTime(2001),
          lastDate: DateTime.now(),
          onDateChanged: widget.onChangeDate,
        ),
      ],
    );
  }
}
