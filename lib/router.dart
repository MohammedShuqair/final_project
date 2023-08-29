import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/screens/login_view.dart';
import 'package:final_project/features/auth/views/screens/register_view.dart';
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
        builder: (_) => const HomeView(),
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
