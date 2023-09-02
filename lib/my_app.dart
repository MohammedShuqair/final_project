import 'package:final_project/router.dart';
import 'package:final_project/core/util/themes.dart';
import 'package:final_project/test_pick_view.dart';
import 'package:flutter/material.dart';
import 'features/auth/views/screens/auth_view.dart';
import 'shared/screens/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: lightTheme,
      initialRoute: AuthView.id,
      // home: PickView(),
      onGenerateRoute: generateRoute,
    );
  }
}
