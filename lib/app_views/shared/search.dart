import 'package:flutter/material.dart';

import '../../core/util/colors.dart';
import '../../core/util/styles.dart';
import 'core_background.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Core(
      child: Row(
        children: [
          const Icon(Icons.search,
              size: 17, color: kSubText), //mistake in color
          const SizedBox(
            width: 8,
          ),
          Text(
            "Search",
            style: kSearchText,
          )
        ],
      ),
    );
  }
}
