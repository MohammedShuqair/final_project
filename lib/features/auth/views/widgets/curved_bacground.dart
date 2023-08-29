import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';

class CurvedBackground extends StatelessWidget {
  const CurvedBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.5,
            color: kLightSub,
          ),
        ),
        child,
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double fy1 = 0.8;
    double fy2 = fy1 * 0.75;
    double fx1 = 0.2;
    double fx2 = fx1 * 2;
    double fx3 = fx2 + (1 - fx2) / 2;

    Path path = Path();
    path.lineTo(0, height * fy1);
    path.quadraticBezierTo(width * fx1, height, width * fx2, height);
    path.quadraticBezierTo(width * fx3, height, width, height * fy2);

    path.lineTo(width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) => false;
}
