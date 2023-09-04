import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/test_api_view/test_shimmer.dart';
import 'package:final_project/views/shared/responce_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDataListView extends StatefulWidget {
  const CategoryDataListView({Key? key}) : super(key: key);

  @override
  State<CategoryDataListView> createState() => _CategoryDataListViewState();
}

class _CategoryDataListViewState extends State<CategoryDataListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<CategoryProvider, ApiResponse<Category>?>(
          selector: (_, provider) => provider.singleCategory,
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
                      return Text(
                        'single category $data',
                        style: const TextStyle(
                            backgroundColor: Colors.greenAccent,
                            color: Colors.black),
                      );
                    }),
              );
            } else {
              return const Center(
                  child: Text('some thing wrong please try again'));
            }
          },
        ),
        Selector<CategoryProvider, ApiResponse<List<Category>>>(
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
                            separatorBuilder: (_, index) => const SizedBox(
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
                                    "senders :${data[index].senders}",
                                    style: const TextStyle(
                                        backgroundColor: kLightSub),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "sendersCount :${data[index].sendersCount}",
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
          selector: (_, provider) => provider.allCategory,
          child: const Divider(),
        ),
      ],
    );
  }
}
