import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.child,
    this.baseColor,
    this.highlightColor,
    this.duration,
  });
  final Widget? child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      period: duration ?? const Duration(seconds: 1),
      child: child ?? const CircularProgressIndicator(),
    );
  }
}
