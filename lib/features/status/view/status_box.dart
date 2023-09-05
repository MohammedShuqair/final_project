
import 'package:flutter/material.dart';

import '../../../core/util/styles.dart';
import '../../../shared/widgets/core_background.dart';

class StatusClass extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  final Widget? statusNumber;

  const StatusClass({
    Key? key,
    required this.statusColor,
    required this.statusText,
    this.statusNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Core(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              statusNumber!,
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            statusText,
            style: kStatusNameTextStyle,
          )
        ],
      ),
    );
  }
}