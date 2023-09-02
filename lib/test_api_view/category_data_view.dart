import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/test_api_view/test_shimmer.dart';
import 'package:final_project/shared/widgets/responce_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDataListView extends StatefulWidget {
  const CategoryDataListView({Key? key}) : super(key: key);

  @override
  State<CategoryDataListView> createState() => _CategoryDataListViewState();
}

class _CategoryDataListViewState extends State<CategoryDataListView> {
  TextEditingController name = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<CategoryProvider, ApiResponse<Category>>(
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
                      return Text(
                        'single category $data',
                        style: TextStyle(
                            backgroundColor: Colors.greenAccent,
                            color: Colors.black),
                      );
                    }),
              );
            },
            selector: (_, provider) => provider.singleCategory),
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
                        SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: data?.length ?? 0,
                            separatorBuilder: (_, index) => SizedBox(
                              height: 8,
                            ),
                            itemBuilder: (_, index) => Container(
                              color: kUnselect,
                              child: Column(
                                children: [
                                  Text(
                                    "id :${data![index].id}",
                                    style:
                                        TextStyle(backgroundColor: kLightSub),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "name :${data[index].name}",
                                    style:
                                        TextStyle(backgroundColor: kLightSub),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "senders :${data[index].senders}",
                                    style:
                                        TextStyle(backgroundColor: kLightSub),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "sendersCount :${data[index].sendersCount}",
                                    style:
                                        TextStyle(backgroundColor: kLightSub),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "updatedAt link :${data[index].updatedAt}",
                                    style:
                                        TextStyle(backgroundColor: kLightSub),
                                  ),
                                  SizedBox(
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