import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.height = 103,
    this.width = 67,
    this.style = kLogo,
    this.margin = 27,
  });
  const Logo.small({
    super.key,
    this.height = 75,
    this.width = 56,
    required this.style,
    this.margin = 8,
  });
  final double height;
  final double width;
  final TextStyle style;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/palestine_bird.png',
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: margin,
        ),
        Text(
          'ديوان رئيس الوزراء',
          style: style,
        )
      ],
    );
  }
}
