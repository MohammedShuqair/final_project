import 'package:final_project/app_views/sender/provider/sender_search_provider.dart';
import 'package:final_project/app_views/sender/views/widgets/sender_list.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SenderView extends StatefulWidget {
  const SenderView({Key? key}) : super(key: key);
  static const String id = '/senderView';

  @override
  State<SenderView> createState() => _SenderViewState();
}

class _SenderViewState extends State<SenderView> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    // context.read<SenderSearchProvider>().createListView().listen((page) {
    //   print("page $page");
    //   // currentPage = page;
    //   // notifyListeners();
    // })
    // ;
    scrollController.addListener(() {
      print('start');
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        print("here");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
        controller: context.watch<SenderSearchProvider>().scrollController,
        children: [
          Consumer<SenderSearchProvider>(
            builder: (context, provider, child) {
              return CustomSearchBar(
                onSubmitted: (String name) => provider.onSearchSubmitted(name),
                onCancel: () => provider.reset(),
              );
            },
          ),
          const SSizedBox(
            height: 48,
          ),
          const Divider(),
          const SSizedBox(
            height: 12,
          ),
          Consumer<SenderSearchProvider>(
            builder: (context, provider, child) {
              return ResponseBuilder(
                response: provider.allSenderResponse,
                onComplete: (_, senderResponse, __, more) {
                  if (senderResponse.senders == null ||
                      senderResponse.senders!.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 0.1.sh),
                      child: Center(
                          child: Text(
                        'No senders found',
                        style: kStatusNumberTextStyle,
                      )),
                    );
                  } else {
                    return Column(
                      children: [
                        SenderList(
                            controller: scrollController,
                            senders: senderResponse.senders ?? [],
                            onTapSender: (sender) {}),
                        if (more)
                          SenderList(
                            isShimmer: true,
                            senders: List.generate(
                                2, (index) => Sender(name: lorem(words: 1))),
                          )
                      ],
                    );
                  }
                },
                onLoading: (_) {
                  return SenderList(
                    isShimmer: true,
                    senders: List.generate(
                        5, (index) => Sender(name: lorem(words: 1))),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
