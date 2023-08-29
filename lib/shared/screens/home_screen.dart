import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/shared/screens/splash_view.dart';
import 'package:flutter/material.dart';

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
      ),
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
