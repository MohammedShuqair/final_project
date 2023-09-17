import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/widgets/tag_view.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/tags_wrap.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              return Hero(
                tag: 'tag',
                child: Material(
                  child: TagWrap(
                    onTap: (Tag tag) {
                      Navigator.pushNamed(context, TagsView.id,
                          arguments: {'tags': data, 'selected': tag});
                    },
                    tags: data,
                    selectedTags: {},
                  ),
                ),
              );
            },
            onLoading: (_) {
              return Wrap(
                //Shimmer
                spacing: 8,
                runSpacing: 8, //here is question
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
