import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/provider/tag_provider.dart';
import 'package:final_project/test_api_view/test_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagDataListView extends StatefulWidget {
  const TagDataListView({Key? key}) : super(key: key);

  @override
  State<TagDataListView> createState() => _TagDataListViewState();
}

class _TagDataListViewState extends State<TagDataListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Text('getMailTagsResponse'),
              Selector<TagProvider, ApiResponse<List<Tag>>?>(
                selector: (_, provider) => provider.getMailTagsResponse,
                builder: (context, response, child) {
                  if (response != null) {
                    return Expanded(
                      child: ResponseBuilder(
                          response: response,
                          onError: (context, message) {
                            return Center(
                              child: Text(message ?? 'error'),
                            );
                          },
                          onLoading: (_) {
                            return ListView.separated(
                              itemBuilder: (_, __) {
                                return const TestShimmer();
                              },
                              separatorBuilder: (_, __) => const Divider(),
                              itemCount: 1,
                            );
                          },
                          onComplete: (context, data, message) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: data?.length ?? 0,
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(
                                      height: 8,
                                    ),
                                    itemBuilder: (_, index) => Container(
                                      color: kUnselect,
                                      child: Column(
                                        children: [
                                          Text(
                                            "id :${data![index].id}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "name :${data[index].name}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "mails :${data[index].mails}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "pivot :${data[index].pivot}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "updatedAt link :${data[index].updatedAt}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                  return SizedBox();
                },
                child: const Divider(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('tagsWithMailsResponse'),
              Selector<TagProvider, ApiResponse<List<Tag>>?>(
                selector: (_, provider) => provider.tagsWithMailsResponse,
                builder: (context, response, child) {
                  if (response != null) {
                    return Expanded(
                      child: ResponseBuilder(
                          response: response,
                          onError: (context, message) {
                            return Center(
                              child: Text(message ?? 'error'),
                            );
                          },
                          onLoading: (_) {
                            return ListView.separated(
                              itemBuilder: (_, __) {
                                return const TestShimmer();
                              },
                              separatorBuilder: (_, __) => const Divider(),
                              itemCount: 1,
                            );
                          },
                          onComplete: (context, data, message) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: data?.length ?? 0,
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(
                                      height: 8,
                                    ),
                                    itemBuilder: (_, index) => Container(
                                      color: kUnselect,
                                      child: Column(
                                        children: [
                                          Text(
                                            "id :${data![index].id}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "name :${data[index].name}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "mails :${data[index].mails}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "pivot :${data[index].pivot}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "updatedAt link :${data[index].updatedAt}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                  return SizedBox();
                },
                child: const Divider(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('allTagResponse'),
              Selector<TagProvider, ApiResponse<List<Tag>>>(
                selector: (_, provider) => provider.allTagResponse,
                builder: (context, response, child) {
                  return Expanded(
                    child: ResponseBuilder(
                        response: response,
                        onError: (context, message) {
                          return Center(
                            child: Text(message ?? 'error'),
                          );
                        },
                        onLoading: (_) {
                          return ListView.separated(
                            itemBuilder: (_, __) {
                              return const TestShimmer();
                            },
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: 1,
                          );
                        },
                        onComplete: (context, data, message) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 38,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: data?.length ?? 0,
                                  separatorBuilder: (_, index) =>
                                      const SizedBox(
                                    height: 8,
                                  ),
                                  itemBuilder: (_, index) => Container(
                                    color: kUnselect,
                                    child: Column(
                                      children: [
                                        Text(
                                          "id :${data![index].id}",
                                          style: const TextStyle(
                                              backgroundColor: kLightSub),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "name :${data[index].name}",
                                          style: const TextStyle(
                                              backgroundColor: kLightSub),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "mails :${data[index].mails}",
                                          style: const TextStyle(
                                              backgroundColor: kLightSub),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "pivot :${data[index].pivot}",
                                          style: const TextStyle(
                                              backgroundColor: kLightSub),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "updatedAt link :${data[index].updatedAt}",
                                          style: const TextStyle(
                                              backgroundColor: kLightSub),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  );
                },
                child: const Divider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
