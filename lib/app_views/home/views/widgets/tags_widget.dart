import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/shared/custom_shimmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/tags_wrap.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/core/util/extensions.dart';
import '../../../shared/core_background.dart';
import 'chip_tag_widget.dart';

class Tags extends StatelessWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Core(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Consumer<HomeProvider>(
        builder: (_, provider, child) {
          return ResponseBuilder(
            response: provider.allTagResponse,
            onComplete: (_, data, message) {
              return TagWrap(
                onTap: (Tag tag) {
                  Scaffold.of(context)
                      .showBottomSheet((context) => Container());
                },
                tags: data,
                selectedTags: {},
              );
            },
            onLoading: (_) {
              return Wrap(
                //Shimmer
                spacing: 8,
                runSpacing: 4, //here is question
                children: List.generate(
                  4,
                  (index) => const ChipWidget.shimmer(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
