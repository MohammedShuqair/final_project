import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatefulWidget {
  const CircleImage({
    super.key,
    required this.imagePath,
    this.size = 24,
  });
  final String imagePath;
  final double size;

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  bool? isValid;
  @override
  void initState() {
    widget.imagePath.isImageValid().then((value) {
      if (mounted) {
        setState(() {
          isValid = value;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fallBackIconSize = widget.size * 0.75;
    bool isLarge = widget.size > 26;
    Widget fallBack = Container(
      height: widget.size,
      width: widget.size,
      padding: isLarge ? const EdgeInsets.all(5) : null,
      decoration: BoxDecoration(
        color: kWhite,
        shape: BoxShape.circle,
        border: Border.all(color: kUnselect),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: kUnselect,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person_outline,
          color: kWhite,
          size: isLarge ? fallBackIconSize - 5 : fallBackIconSize,
        ),
      ),
    );
    if (isValid != null && isValid == true) {
      return Container(
        height: widget.size,
        width: widget.size,
        padding: widget.size > 26 ? const EdgeInsets.all(5) : null,
        decoration: BoxDecoration(
          color: kWhite,
          shape: BoxShape.circle,
          border: Border.all(color: kUnselect),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.size),
            child: Image.network(
              widget.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, e, ___) {
                return fallBack;
              },
            )),
      );
    } else {
      return fallBack;
    }
  }
}
