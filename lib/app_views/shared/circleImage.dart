import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatefulWidget {
  const CircleImage({
    super.key,
    required this.imagePath,
    this.size = 24,
  });
  final String imagePath;
  final double? size;

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  bool? isValid;
  @override
  void initState() {
    widget.imagePath.isImageValid().then((value) {
      setState(() {
        isValid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget fallBack = Container(
      height: widget.size,
      width: widget.size,
      decoration: const BoxDecoration(color: kUnselect, shape: BoxShape.circle),
      child: const Icon(
        Icons.person_outline,
        color: kWhite,
      ),
    );
    if (isValid != null && isValid == true) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            imageUrl + widget.imagePath,
            width: widget.size,
            height: widget.size,
            fit: BoxFit.contain,
            errorBuilder: (_, e, ___) {
              print(e);
              return fallBack;
            },
          ));
    } else {
      return fallBack;
    }
  }
}
