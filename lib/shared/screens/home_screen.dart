import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/data_view.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:final_project/shared/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/current_user/repo/current_user_repo.dart';

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
              context.read<CategoryProvider>().getAllCategories();
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // CurrentUserRepository().getCurrentUser();
            },
          ),
        ],
      ),
      body: const DataListView(),
    );
  }

  void _logout(BuildContext context, UserProvider provider) async {
    await provider.logout();
    handelResponseStatus(
      provider.currentUserResponse.status,
      context,
      message: provider.currentUserResponse.message,
      onComplete: () {
        print('here');
        Navigator.pushNamedAndRemoveUntil(
            context, SplashView.id, (route) => false);
      },
    );
  }
}
