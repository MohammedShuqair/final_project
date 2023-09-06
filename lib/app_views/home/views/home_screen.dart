import 'package:final_project/app_views/sender/views/widgets/sender_view.dart';
import 'package:final_project/app_views/shared/search_bar.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';
import 'package:final_project/features/tag/provider/tag_provider.dart';
import 'package:final_project/test_api_view/tag_data_view.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/features/auth/views/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const String id = '/homeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return IconButton(
              onPressed: () => _logout(context, provider),
              icon: const Icon(Icons.logout),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // context.read<CategoryProvider>().getAllCategories();
              // context.read<CategoryProvider>().getSingleCategory(1);
              // context.read<CategoryProvider>().createCategory('test team 7');
              // context.read<TagProvider>().getMailTags(2);
              // context.read<TagProvider>().getTagsWithMails([1, 2, 3]);
              //Reloaded 1 of 1425 libraries in 1,361ms (compile: 229 ms, reload: 493 ms, reassemble: 494 ms).
              // I/flutter ( 7209): [Mail{id: 31, subject: test2, description: first team 7 test, senderId: 1, archiveNumber: 2000, archiveDate: 2023-10-20 00:00:00, decision: null, statusId: 1, finalDecision: null, createdAt: 2023-09-05T23:23:21.000000Z, updatedAt: 2023-09-05T23:23:21.000000Z, sender: Sender {id: 1, name: mohammed shqair1, mobile: 0592020858, address: null, categoryId: 7, createdAt: 2023-08-24T12:10:41.000000Z, updatedAt: 2023-09-02T21:59:09.000000Z, mail count: null, category: Category {id: 7, name: team 7, createdAt: 2023-09-02T18:10:28.000000Z, updatedAt: 2023-09-02T18:10:28.000000Z, sendersCount: null, senders: []}}, status: Instance of 'MailStatus', tags: [Tag{id: 3, name: new tag, createdAt: 2023-09-01T07:15:38.000000Z, updatedAt: 2023-09-01T07:15:38.000000Z, mails: [], pivot: mailId: 31, tagId: 3}, Tag{id: 2, name: ahmed, createdAt: 2023-08-31T18:30:46.000000Z, updatedAt: 2023-08-31T18:30:46.000000Z, mails: [], pivot: mailId: 31, tagId: 2}], attachments: [], activities: [Activity{id: 55, body: lets do it, userId: 6, ma
              try {
                await MailRepository().updateMail(
                  mailId: 31,
                  statusId: "1",
                  decision: '',
                  finalDecision: '',
                  /*     tags: [1],
                idAttachmentsForDelete: [],
                pathAttachmentsForDelete: [],
                activities: [],*/
                );
              } catch (e, s) {
                print(e.toString());
                print(s.toString());
              }
            },
          ),
          TextButton(
            child: const Text('go to sender'),
            onPressed: () {
              Navigator.pushNamed(context, SenderView.id);
            },
          ),
        ],
      ),
      body: CustomSearchBar(
        onSubmitted: (String value) {
          print(value);
        },
      )
      /* Selector<CategoryProvider, ApiResponse<Category>?>(
        selector: (context, provider) => provider.createdCategoryResponse,
        builder: (context, value, child) {
          return Text('create data ${value?.data}');
        },
      )*/
      ,
    );
  }

  void _logout(BuildContext context, UserProvider provider) async {
    await provider.logout();
    handelResponseStatus(
      provider.currentUserResponse.status,
      context,
      message: provider.currentUserResponse.message,
      onComplete: () {
        Navigator.pushNamedAndRemoveUntil(
            context, SplashView.id, (route) => false);
      },
    );
  }
}
