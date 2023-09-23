import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/home/views/widgets/chip_tag_widget.dart';
import 'package:final_project/app_views/shared/app_text_field.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/sheet_bar.dart';
import 'package:final_project/app_views/shared/tags_wrap.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagSheet extends StatefulWidget {
  const TagSheet({Key? key, required this.onTapDone, required this.selected})
      : super(key: key);
  final void Function(Set<Tag> selected) onTapDone;
  final Set<Tag> selected;

  @override
  State<TagSheet> createState() => _TagSheetState();
}

class _TagSheetState extends State<TagSheet> {
  Set<Tag> selected = {};
  Set<Tag> all = {};
  late TextEditingController controller;
  ApiResponse<Set<Tag>>? allTagResponse;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    controller = TextEditingController();
    selected.addAll(widget.selected);
    getAllTags();
    super.initState();
  }

  Future<void> getAllTags() async {
    allTagResponse = ApiResponse.loading(message: 'logging...');
    setState(() {});
    try {
      final List<Tag> tags = await TagRepository().getAllTag();

      allTagResponse = ApiResponse.completed(tags.toSet(),
          message: 'Tags fetched successfully');
      all.addAll(tags);
      selected.forEach((s) {
        if (!all
            .map((e) => e.name?.toLowerCase())
            .contains(s.name?.toLowerCase())) {
          all.add(s);
        }
      });
      setState(() {});
    } catch (e) {
      allTagResponse = ApiResponse.error(message: e.toString());
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.0.h, bottom: 57.h),
            child: SheetBar(
                onTapDone: () => widget.onTapDone(selected),
                hint: context.tr('tags')),
          ),
          Core(
            child: ResponseBuilder<Set<Tag>>(
              response: allTagResponse,
              onComplete: (_, ___, __, more) {
                return TagWrap(
                  tags: all,
                  leading: true,
                  selectedTags: selected,
                  onTap: (t) {
                    setState(() {
                      if (!selected.map((e) => e.id).contains(t.id)) {
                        selected.add(t);
                      } else {
                        selected.removeWhere((e) => e.id == t.id);
                      }
                    });
                    // Navigator.pop(context, c);
                  },
                );
              },
              onError: (_, message) {
                return Text(message ?? '');
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
            ),
          ),
          const SSizedBox(
            height: 10,
          ),
          Core(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: key,
                child: AppTextField(
                  hintText: context.tr('add_new_tags'),
                  controller: controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Tag Name";
                    }
                    return null;
                  },
                  onSubmitted: (value) {
                    if (key.currentState?.validate() ?? false) {
                      Tag? t = getIfExist(value);

                      setState(() {
                        if (t == null) {
                          t = Tag(name: value);
                          all.add(t!);
                        }
                        selected.add(t!);
                      });
                      controller.clear();
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }

  Tag? getIfExist(String value) {
    for (int i = 0; i < all.length; i++) {
      if (all.elementAt(i).name?.toLowerCase() == value.toLowerCase()) {
        return all.elementAt(i);
      }
    }
    return null;
  }
}
