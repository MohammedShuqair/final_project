import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_detailes_and_new_inbox/CircleImage.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendActivityBar extends StatefulWidget {
  static const String id = "/sendActivity";

  const SendActivityBar({super.key, required this.onSubmitted});
  final void Function(String value) onSubmitted;

  @override
  State<SendActivityBar> createState() => _SendActivityBarState();
}

class _SendActivityBarState extends State<SendActivityBar> {
  late TextEditingController controller;
  late FocusNode focusNode;
  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onSubmitted: (v) {
        onDone();
      },
      onChanged: (v) {
        setState(() {});
      },
      style: textInTagTextStyle.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: "Add new Activity …",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none),
          fillColor: controller.text.isNotEmpty ? kUnselect : kWhite,
          filled: true,
          prefixIconConstraints:
              const BoxConstraints.tightFor(height: 24, width: 24 + 16 + 9),
          prefixIcon: const Padding(
            padding: EdgeInsetsDirectional.only(start: 16, end: 9),
            child: CircleImage(
              imagePath: "assets/images/palestine_bird.png",
            ),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                onDone();
              },
              icon: SvgPicture.asset('assets/icons/send_Icon.svg'))),
    );
    // return Container(
    //     padding: const EdgeInsets.symmetric(vertical: 15),
    //     decoration: BoxDecoration(
    //         color: Colors.grey[300],
    //         borderRadius: const BorderRadius.all(Radius.circular(30))),
    //     child: Row(
    //       children: [
    //         const SSizedBox(
    //           width: 14,
    //         ),
    //         const CircleImage(
    //           imagePath: "assets/images/palestine_bird.png",
    //         ),
    //         const SSizedBox(
    //           width: 8,
    //         ),
    //         Text(
    //           'Add new Activity …',
    //           style: TextStyle(
    //             color: Colors.grey,
    //             fontSize: 14.sp,
    //           ),
    //         ),
    //         const Spacer(),
    //         SvgPicture.asset(
    //           'assets/icons/send.svg',
    //           width: 32.0,
    //           height: 28.0,
    //         ),
    //         const SSizedBox(
    //           width: 14,
    //         ),
    //       ],
    //     ));
  }

  void onDone() {
    if (controller.text.isNotEmpty) {
      setState(() {
        widget.onSubmitted(controller.text);
        controller.clear();
        focusNode.unfocus();
      });
    }
  }
}
