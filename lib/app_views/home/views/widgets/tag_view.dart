import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/core_background.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/expansion_tile.dart';
import 'package:final_project/app_views/shared/shimmers/expansions_shmmer.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/tags_wrap.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagsView extends StatefulWidget {
  const TagsView({Key? key, required this.selected, required this.tags})
      : super(key: key);
  static const String id = '/tagView';
  final Tag selected;
  final Set<Tag> tags;

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  Set<Tag> selected = {};
  Map<String, List<Mail>> body = {};
  final TagRepository _repository = TagRepository();

  ApiResponse<List<Tag>>? tagsWithMailsResponse;

  Future<void> getTagsWithMails() async {
    if (tagsWithMailsResponse?.data == null) {
      tagsWithMailsResponse = ApiResponse.loading(message: 'logging...');
    } else {
      tagsWithMailsResponse = ApiResponse.more(
          message: 'logging...', data: tagsWithMailsResponse?.data);
    }
    setState(() {});
    try {
      final List<Tag> tags = await _repository
          .getTagsWithMails(selected.map((e) => e.id!).toList());
      body.clear();
      tags.forEach((tag) {
        body.addAll({tag.name ?? '': tag.mails ?? []});
      });
      tagsWithMailsResponse = ApiResponse.completed(tags,
          message: 'Tags with mails fetched successfully');
      setState(() {});
    } catch (e) {
      tagsWithMailsResponse = ApiResponse.error(message: e.toString());
      setState(() {});
    }
  }

  @override
  void initState() {
    selected.add(widget.selected);
    getTagsWithMails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "tags".tr().firstCapital(),
          style: kTitleMailCard,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kLightSub,
          ),
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          await getTagsWithMails();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          children: [
            Hero(
              tag: 'tag',
              child: Material(
                child: Core(
                  child: TagWrap(
                    tags: widget.tags.toSet(),
                    leading: true,
                    selectedTags: selected,
                    onTap: (t) {
                      setState(() {
                        if (!selected.map((e) => e.id).contains(t.id)) {
                          selected.add(t);
                        } else {
                          selected.removeWhere((e) => e.id == t.id);
                        }
                        getTagsWithMails();
                      });
                      // Navigator.pop(context, c);
                    },
                  ),
                ),
              ),
            ),
            const SSizedBox(
              height: 48,
            ),
            ResponseBuilder(
              response: tagsWithMailsResponse,
              onComplete: (_, data, __, more) {
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        String key = body.keys.elementAt(index);
                        List<Mail> mails = body[key] ?? [];
                        return ExpansionWidget(
                          key: ValueKey(data.hashCode),
                          title: key,
                          cards: []..listMail(mails, (mail) {
                              showMailDetailsSheet(
                                  context, mail, getTagsWithMails);
                            }),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const SSizedBox(
                          height: 14,
                        );
                      },
                      itemCount: data.length,
                    ),
                    if (more)
                      ExpansionsShimmer(
                        titles: selected.map((e) => e.name).toList()
                          ..removeWhere((newTag) =>
                              data.any((old) => old.name == newTag)),
                      )
                  ],
                );
              },
              onLoading: (_) {
                return ExpansionsShimmer(
                  titles: [widget.selected.name],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
