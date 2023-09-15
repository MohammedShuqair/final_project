import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MailImage extends StatelessWidget {
  const MailImage({
    super.key,
    required this.path,
    this.fromNetwork = true,
  });
  final String path;
  final bool fromNetwork;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        image: getImageProvider(),
        fit: BoxFit.fill,
        width: 36.w,
        height: 36.w,
        errorBuilder: (_, e, ___) {
          print(e);
          print(___);
          return SizedBox(
            height: 36.w,
            width: 36.w,
            child: Placeholder(
                child: Center(
              child: Text(
                'image error',
                style: TextStyle(fontSize: 8.sp),
                textAlign: TextAlign.center,
              ),
            )),
          );
        },
      ),
    );
  }

  ImageProvider<Object> getImageProvider() {
    if (fromNetwork) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }
}
