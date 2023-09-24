import 'package:final_project/app_views/home/provider/home_provider.dart';
import 'package:final_project/app_views/home/views/widgets/user_information.dart';
import 'package:final_project/app_views/search/views/search_screen.dart';
import 'package:final_project/app_views/shared/circleImage.dart';
import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/features/auth/views/screens/splash_view.dart';
import 'package:final_project/features/current_user/provider/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key, this.toolbarHeight, this.bottomHeight})
      : super(key: key);
  final double? toolbarHeight;
  final double? bottomHeight;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchView.id)
                .then((value) => context.read<HomeProvider>().init());
          },
          icon: const Icon(Icons.search),
        ),
        Consumer<UserProvider>(
          builder: (context, provider, child) {
            return ResponseBuilder(
              response: provider.currentUserResponse,
              onComplete: (_, user, __, more) {
                return PopupMenuButton(
                  surfaceTintColor: Colors.white,
                  clipBehavior: Clip.hardEdge,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  position: PopupMenuPosition.under,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context2) {
                    return <PopupMenuEntry<dynamic>>[
                      PopupMenuItem(
                        padding: EdgeInsets.zero,
                        height: 0,
                        child: UserInformationDialog(
                          user: user,
                          onTapLogout: () {
                            _logout(context, provider);
                          },
                        ),
                      ),
                    ];
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 20.w),
                    child: CircleImage(
                      imagePath: '$imageUrl${user.image}',
                      size: 40,
                    ),
                  ),
                );
              },
              onLoading: (_) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(end: 20.w),
                  child: CircleImage(
                    imagePath: getUser().image ?? '',
                    size: 40,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _logout(BuildContext context, UserProvider provider) {
    provider.logout().then((value) {
      handelResponseStatus(
        provider.currentUserResponse.status,
        context,
        message: provider.currentUserResponse.message,
        onComplete: () {
          Navigator.pushNamedAndRemoveUntil(
              context, SplashView.id, (route) => false);
        },
      );
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => _PreferredAppBarSize(toolbarHeight, bottomHeight);
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
