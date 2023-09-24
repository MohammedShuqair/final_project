import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/features/sender/provider/sender_provider.dart';
import 'package:final_project/test_api_view/sender_data_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SenderView extends StatelessWidget {
  static const String id = '/senderView';
  const SenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.read<SenderProvider>().getAllSenders(1, false);
              },
              child: const Text('all ')),
          TextButton(
              onPressed: () {
                context
                    .read<SenderProvider>()
                    .createSender('shuqair', '0592509703', 'khanyounes', "7");
              },
              child: const Text('create ')),
          TextButton(
              onPressed: () {
                context
                    .read<SenderProvider>()
                    .updateSender(33, 'abu shuqair', '0', 'gaza', "7");
              },
              child: const Text('update ')),
          TextButton(
              onPressed: () async {
                await context.read<SenderProvider>().deleteSenders(33);

                handelResponseStatus(
                    context
                            .read<SenderProvider>()
                            .deleteSenderResponse
                            ?.status ??
                        ApiStatus.LOADING,
                    context,
                    onComplete: () {});
              },
              child: const Text('delete')),
        ],
      ),
      body: const SenderDataListView(),
    );
  }
}
