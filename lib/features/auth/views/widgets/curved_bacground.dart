import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/views/shared/logo.dart';
import 'package:flutter/material.dart';

class CurvedBackground extends StatelessWidget {
  const CurvedBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SingleChildScrollView(
      child: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                kLightSub,
                kDarkSub.withOpacity(0.8),
              ])),
              width: double.infinity,
              height: isPortrait ? h * 0.45 : h * 0.7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 68.0,
                ),
                Hero(
                    tag: 'logo',
                    child: Logo.small(style: kLogo.copyWith(fontSize: 22))),
                const SizedBox(
                  height: 18.0,
                ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double fy1 = 0.8;
    double fy2 = fy1 * 0.85;
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
