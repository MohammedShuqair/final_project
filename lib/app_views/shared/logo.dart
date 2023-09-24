import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({
    super.key,
    this.height = 103,
    this.width = 67,
    this.margin = 27,
  }) {
    style = kLogo;
  }
  Logo.small({
    super.key,
    this.height = 75,
    this.width = 56,
    required this.style,
    this.margin = 8,
  });
  final double height;
  final double width;
  TextStyle? style;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/palestine_bird.png',
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          SSizedBox(
            height: margin,
          ),
          Text(
            context.tr('prime_ministers_office'),
            style: style,
          )
        ],
      ),
    );
  }
}
