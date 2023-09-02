import 'package:final_project/router.dart';
import 'package:final_project/core/util/themes.dart';
import 'package:flutter/material.dart';
import 'shared/screens/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: lightTheme,
      initialRoute: SplashView.id,
      // home: PickView(),
      onGenerateRoute: generateRoute,
    );
  }
}
