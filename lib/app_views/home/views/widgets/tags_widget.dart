import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/features/tag/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/core_background.dart';
import 'package:final_project/core/util/styles.dart';
import 'chip_tag_widget.dart';

class Tags extends StatefulWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  bool isLoading = true;

  void getData() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tags",
          style: tagTitleTextStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        Consumer<TagProvider>(
          builder: (_, provider, child) {
            return ResponseBuilder(
                response: provider.allTagResponse,
                onComplete: (_, data, message) {
                  print(data);
                  return Core(
                    padding: const EdgeInsets.all(16.0),
                    child: isLoading
                        ? Wrap(
                            //Shimmer
                            spacing: 8,
                            runSpacing: 4, //here is question
                            children: List.generate(
                              4,
                              (index) => const ChipWidget(tagTitle: "shimmer"),
                            ),
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 4, //here is question
                            children: List.generate(
                              data!.length,
                              (index) =>
                                   ChipWidget(tagTitle: data![index]!.name.toString()),
                            ),
                          ),
                  );
                });
          },
        ),
      ],
    );
  }
}
