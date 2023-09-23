import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/router.dart';
import 'package:final_project/core/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/views/screens/splash_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(),
      child: ScreenUtilInit(
        designSize: const Size(428, 892),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Final Project',
          theme: lightTheme,
          initialRoute: SplashView.id,
          // home: ScrollControllerDemo(),
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
