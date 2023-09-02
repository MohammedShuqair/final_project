import 'package:final_project/features/auth/views/widgets/custom_text_form_field.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/test_api_view/test_shimmer.dart';
import 'package:final_project/shared/widgets/responce_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataListView extends StatefulWidget {
  const DataListView({Key? key}) : super(key: key);

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  TextEditingController name = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return ResponseBuilder(
            response: provider.currentUserResponse,
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
              return ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField.email(
                          controller: name,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            provider.updateUser(name.text);
                          },
                          icon: const Icon(Icons.send))
                    ],
                  ),
                  Text("id :${data?.id}"),
                  Text("name :${data?.name}"),
                  Text("email :${data?.email}"),
                  Text("image link :${data?.image}"),
                  Text("role :${data?.role?.name}"),
                ],
              );
            });
      },
      child: const Divider(),
    );
  }
}
