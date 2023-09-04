import 'package:flutter/material.dart';

class Core extends StatelessWidget {
  const Core({Key? key, required this.child, this.margin, this.padding})
      : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: child,
    );
  }
}
