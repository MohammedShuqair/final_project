import 'package:final_project/app_views/current_user_profile/current_user_profile.dart';
import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/provider/single_status_provider.dart';
import 'package:final_project/app_views/home/views/home_screen.dart';
import 'package:final_project/app_views/home/views/widgets/app_drawer.dart';
import 'package:final_project/app_views/home/views/widgets/status_view.dart';
import 'package:final_project/app_views/home/views/widgets/tag_view.dart';
import 'package:final_project/app_views/mail_details/views/mail_details_screen.dart';
import 'package:final_project/app_views/search/provider/search_provider.dart';
import 'package:final_project/app_views/search/views/search_screen.dart';
import 'package:final_project/app_views/sender/provider/sender_search_provider.dart';
import 'package:final_project/app_views/sender/provider/single_sender_provider.dart';
import 'package:final_project/app_views/sender/views/sender_mails.dart';
import 'package:final_project/app_views/sender/views/senders_view.dart';
import 'package:final_project/app_views/users_management/providers/global_user_provider.dart';
import 'package:final_project/app_views/users_management/providers/management_provider.dart';
import 'package:final_project/app_views/users_management/screens/all_users/all_users.dart';
import 'package:final_project/app_views/users_management/screens/create_user/create_user.dart';
import 'package:final_project/app_views/users_management/screens/user_profile/user_profile.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/auth/provider/auth_provider.dart';
import 'package:final_project/features/auth/views/screens/auth_view.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/auth/views/screens/splash_view.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_views/mail_details/details_provider/details_provider.dart';
import 'app_views/users_management/users_management_screen.dart';

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
    case SendersView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => SenderSearchProvider(true),
          child: const SendersView(),
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
        builder: (_) => ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          child: const HomeView(),
        ),
      );

    case AppDrawer.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) => SearchProvider(),
          child: const AppDrawer(),
        ),
      );

    case TagsView.id:
      Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => TagsView(
          selected: map['selected'],
          tags: map['tags'],
        ),
      );
    case MailDetailsView.id:
      return MaterialPageRoute<bool?>(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) =>
              DetailsProvider(settings.arguments as Mail),
          child: const MailDetailsView(),
        ),
      );
    case StatusMailsView.id:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (BuildContext context) =>
              SingleStatusProvider(settings.arguments as Status),
          child: const StatusMailsView(),
        ),
      );
    case CreateUserScreen.id:
      return MaterialPageRoute(builder: (_) => const CreateUserScreen());
    case UsersManagement.id:
      return MaterialPageRoute(builder: (_) => const UsersManagement());
    case CurrentUserProfileScreen.id:
      return MaterialPageRoute(
          builder: (_) => const CurrentUserProfileScreen());
    case SenderMailsView.id:
      return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
                create: (BuildContext context) =>
                    SingleSenderProvider(settings.arguments as Sender),
                child: const SenderMailsView(),
              ));
    case UserProfileScreen.id:
      return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
                create: (BuildContext context) =>
                    GlobalUserProvider(settings.arguments as User),
                child: const UserProfileScreen(),
              ));
    case AllUsersView.id:
      return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
                create: (BuildContext context) => ManagementProvider(),
                child: const AllUsersView(),
              ));
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
