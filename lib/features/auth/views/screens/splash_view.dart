import 'package:final_project/core/util/colors.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/views/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../views/shared/logo.dart';

class SplashView extends StatefulWidget {
  static const String id = "/splashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void checkLogin() async {
    String path;
    await Future.delayed(const Duration(seconds: 2));
    SharedHelper temp = SharedHelper();
    if (temp.getToken().isNotEmpty) {
      path = HomeView.id;
    } else {
      path = AuthView.id;
    }

    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        path,
      );
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [kDarkSub, kLightSub])),
        child: const Hero(
          tag: 'logo',
          child: Logo(),
        ),
      ),
    );
  }
}