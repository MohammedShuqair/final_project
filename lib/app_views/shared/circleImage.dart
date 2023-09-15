import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:flutter/material.dart';

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
            return Container(
              height: size,
              width: size,
              decoration:
                  const BoxDecoration(color: kUnselect, shape: BoxShape.circle),
              child: const Icon(
                Icons.person_outline,
                color: kWhite,
              ),
            );
          },
        ));
  }
}
