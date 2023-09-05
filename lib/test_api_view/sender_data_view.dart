import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/models/sender_response.dart';
import 'package:final_project/features/sender/provider/sender_provider.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/provider/tag_provider.dart';
import 'package:final_project/test_api_view/test_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SenderDataListView extends StatefulWidget {
  const SenderDataListView({Key? key}) : super(key: key);

  @override
  State<SenderDataListView> createState() => _SenderDataListViewState();
}

class _SenderDataListViewState extends State<SenderDataListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text('allSenderResponse'),
              Selector<SenderProvider, ApiResponse<SenderResponse>?>(
                selector: (_, provider) => provider.allSenderResponse,
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
                            List<Sender> senders = data?.senders ?? [];
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: senders.length,
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(
                                      height: 8,
                                    ),
                                    itemBuilder: (_, index) => Container(
                                      color: kUnselect,
                                      child: Column(
                                        children: [
                                          Text(
                                            "id :${senders[index].id}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "name :${senders[index].name}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "mobile :${senders[index].mobile}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "category :${senders[index].category}",
                                            style: const TextStyle(
                                                backgroundColor: kLightSub),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "mailCount :${senders[index].mailCount}",
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
                  return const SizedBox();
                },
                child: const Divider(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text('createSenderResponse'),
              Selector<SenderProvider, ApiResponse<Sender>?>(
                selector: (_, provider) => provider.createSenderResponse,
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
                            return Text('create sender $data');
                          }),
                    );
                  }
                  return const SizedBox();
                },
                child: const Divider(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text('updateSenderResponse'),
              Selector<SenderProvider, ApiResponse<Sender>?>(
                selector: (_, provider) => provider.updateSenderResponse,
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
                            return Text('update data : $data');
                          }),
                    );
                  }
                  return const SizedBox();
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
