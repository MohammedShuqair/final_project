import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/screens/login_view.dart';
import 'package:final_project/features/auth/views/screens/register_view.dart';
import 'package:final_project/features/category/provider/category_provider.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:final_project/features/mail/provider/mail_provider.dart';
import 'package:final_project/features/status/provider/status_provider.dart';
import 'package:final_project/features/tag/provider/tag_provider.dart';
import 'package:final_project/shared/screens/home_screen.dart';
import 'package:final_project/shared/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.id:
      return MaterialPageRoute(
        builder: (_) => const SplashView(),
      );
    case LoginView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => AuthProvider(),
          child: const LoginView(),
        ),
      );

    case RegisterView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => AuthProvider(),
          child: const RegisterView(),
        ),
      );
    case HomeView.id:
      return MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => StatusProvider()),
            ChangeNotifierProvider(create: (_) => CategoryProvider()),
            ChangeNotifierProxyProvider<CategoryProvider, MailProvider>(
              create: (_) => MailProvider(),
              update: (_, categoryProvider, mailProvider) {
                mailProvider?.setData(categoryProvider.response.data ?? []);
                return mailProvider ?? MailProvider();
              },
            ),
            ChangeNotifierProvider(create: (_) => TagProvider()),
          ],
          child: const HomeView(),
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
