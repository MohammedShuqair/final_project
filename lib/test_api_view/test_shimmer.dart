import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';

class TestShimmer extends StatelessWidget {
  const TestShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Core(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lorem(paragraphs: 1, words: 5)),
            const SSizedBox(
              height: 3,
            ),
            Text(lorem(paragraphs: 1, words: 5)),
          ],
        ),
      ),
    );
  }
}
