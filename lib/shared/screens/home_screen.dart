import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/data_view.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:final_project/shared/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const String id = '/homeView';
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _logout(context),
          icon: const Icon(Icons.logout),
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
              StatusRepository().getSingleStatus(2, false);
            },
          ),
        ],
      ),
      body: const DataListView(),
    );
  }

  void _logout(BuildContext context) {
    SharedHelper()
      ..removeData(key: 'user')
      ..removeData(key: 'token').then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, SplashView.id, (route) => false));
  }
}
