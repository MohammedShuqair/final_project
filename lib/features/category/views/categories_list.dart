import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/category/views/test_shimmer.dart';
import 'package:final_project/shared/widgets/core_background.dart';
import 'package:final_project/shared/widgets/custom_shimmer.dart';
import 'package:final_project/shared/widgets/responce_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        return ResponseBuilder(
            response: provider.response,
            onLoading: (_) {
              return ListView.separated(
                itemBuilder: (_, __) {
                  return const TestShimmer();
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: 5,
              );
            },
            onComplete: (context, catList, message) {
              return ListView.separated(
                itemBuilder: (_, index) => Core(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(catList[index]),
                ),
                separatorBuilder: (_, __) => child!,
                itemCount: catList!.length,
              );
            });
      },
      child: const Divider(),
    );
  }
}
