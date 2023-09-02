import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function()? onTap;
  final double? width;
  final String text;

  const AuthButton(
      {super.key,
      required this.onTap,
      this.width = double.infinity,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0XFF6488FF), kDarkSub]),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: kSelectedButton,
        ),
      ),
    );
  }
}
