import 'package:final_project/app_views/home/views/widgets/status_grid_view.dart';
import 'package:final_project/app_views/home/views/widgets/tags_widget.dart';
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
              onPressed: () {
                // context.read<CategoryProvider>().getAllCategories();
                // context.read<CategoryProvider>().getSingleCategory(1);
                // context.read<CategoryProvider>().createCategory('test team 7');
                context.read<TagProvider>().getMailTags(2);
                context.read<TagProvider>().getTagsWithMails([1, 2, 3]);
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
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusGridView(),
                Tags(),
              ],
            ),),
        ),
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
