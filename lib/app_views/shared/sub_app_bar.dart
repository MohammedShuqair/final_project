import 'package:final_project/core/util/colors.dart';
import 'package:flutter/material.dart';

class SubAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SubAppBar({
    super.key,
    required this.title,
    this.actions,
  });
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: kLightSub,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
