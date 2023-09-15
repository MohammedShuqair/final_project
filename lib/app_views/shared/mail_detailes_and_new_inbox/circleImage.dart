import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.imagePath,
    this.size = 24,
  });
  final String imagePath;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          imageUrl + imagePath,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return SSizedBox(
                height: 36,
                width: 36,
                child: Placeholder(
                    child: Center(
                  child: Text(
                    'image error',
                    style: TextStyle(fontSize: 8.sp),
                    textAlign: TextAlign.center,
                  ),
                )));
          },
        ));
  }
}
