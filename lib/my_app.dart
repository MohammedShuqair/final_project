import 'package:final_project/app_views/home/views/widgets/app_drawer.dart';
import 'package:final_project/app_views/mail_details/views/mail_details_screen.dart';
import 'package:final_project/app_views/mail_details/views/widgets/mail_options_sheet.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/router.dart';
import 'package:final_project/core/util/themes.dart';
import 'package:flutter/material.dart';
import 'features/auth/views/screens/splash_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Final Project',
        theme: lightTheme,
        initialRoute: AppDrawer.id,
        // home: PickView(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
