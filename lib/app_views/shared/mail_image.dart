import 'dart:io';

import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MailImage extends StatefulWidget {
  const MailImage({
    super.key,
    required this.path,
    this.fromNetwork = true,
  });
  final String path;
  final bool fromNetwork;

  @override
  State<MailImage> createState() => _MailImageState();
}

class _MailImageState extends State<MailImage> {
  ImageProvider? imageProvider;
  @override
  void initState() {
    if (widget.fromNetwork) {
      widget.path.isImageValid().then((value) {
        if (value && mounted) {
          setState(() {
            imageProvider = NetworkImage(widget.path);
          });
        }
      });
    } else {
      if (File(widget.path).existsSync() && mounted) {
        setState(() {
          imageProvider = FileImage(File(widget.path));
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget fallBack = SizedBox(
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
    if (imageProvider == null) {
      return CustomShimmer(
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
              color: kUnselect, borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      Widget child = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: imageProvider!,
          fit: BoxFit.contain,
          width: 36.w,
          height: 36.w,
          errorBuilder: (_, e, ___) {
            print(e);
            print(___);
            return fallBack;
          },
        ),
      );
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => Center(
                  child: SizedBox.square(dimension: 0.7.sw, child: child)));
        },
        child: child,
      );
    }
  }
}
