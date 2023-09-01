import 'package:final_project/features/status/provider/status_provider.dart';
import 'package:final_project/test_shimmer.dart';
import 'package:final_project/shared/widgets/core_background.dart';
import 'package:final_project/shared/widgets/responce_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataListView extends StatelessWidget {
  const DataListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, provider, child) {
        return ResponseBuilder(
            response: provider.singleStatus,
            onLoading: (_) {
              return ListView.separated(
                itemBuilder: (_, __) {
                  return const TestShimmer();
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: 5,
              );
            },
            onComplete: (context, data, message) {
              return ListView.separated(
                itemBuilder: (_, index) => Core(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    data?.name ?? '',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                separatorBuilder: (_, __) => child!,
                itemCount: 1,
              );
            });
      },
      child: const Divider(),
    );
  }
}
