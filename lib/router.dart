import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/home_screen.dart';
import 'package:final_project/app_views/home/views/widgets/app_drawer.dart';
import 'package:final_project/app_views/mail_details/views/widgets/mail_options_sheet.dart';
import 'package:final_project/app_views/search/provider/search_provider.dart';
import 'package:final_project/app_views/search/views/search_screen.dart';
import 'package:final_project/app_views/sender/views/widgets/sender_view.dart';
import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/features/sender/provider/sender_provider.dart';
import 'package:final_project/features/auth/views/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.id:
      return MaterialPageRoute(
        builder: (_) => const SplashView(),
      );
    case AuthView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => AuthProvider(),
          child: const AuthView(),
        ),
      );
    case SenderView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => SenderProvider(),
          child: const SenderView(),
        ),
      );

    case SearchView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => SearchProvider(),
          child: const SearchView(),
        ),
      );
    case HomeView.id:
      return MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            // ChangeNotifierProvider(create: (_) => UserProvider()),
            // ChangeNotifierProvider(create: (_) => StatusProvider()),
            // ChangeNotifierProvider(create: (_) => CategoryProvider()),
            // ChangeNotifierProxyProvider<CategoryProvider, MailProvider>(
            //   create: (_) => MailProvider(),
            //   update: (_, categoryProvider, mailProvider) {
            //     mailProvider?.setData(categoryProvider.allCategory.data ?? []);
            //     return mailProvider ?? MailProvider();
            //   },
            // ),
            // ChangeNotifierProvider(create: (_) => TagProvider()),
            ChangeNotifierProvider(create: (_) => HomeProvider()),
          ],
          child: const HomeView(),
        ),
      );
    case MailOptionsSheet.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => SearchProvider(),
          child: const MailOptionsSheet(),
        ),
      );

    case AppDrawer.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => SearchProvider(),
          child: const AppDrawer(),
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
