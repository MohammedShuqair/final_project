import 'package:flutter/material.dart';

import '../../../../core/util/colors.dart';

class AppDrawer extends StatefulWidget {
  static const String id = '/appDrawer';
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkSub,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Image.asset(
              'assets/images/palestine_bird.png',
              height: 103,
              width: 67,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'الرئيسة',
                    style: TextStyle(fontSize: 18, color: kWhite),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Image.asset(
                    'assets/icons/home.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'الملف الشخصي',
                    style: TextStyle(fontSize: 18, color: kWhite),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Image.asset(
                    'assets/icons/profile_user.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'المرسلين',
                    style: TextStyle(fontSize: 18, color: kWhite),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Image.asset(
                    'assets/icons/senders.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'إدارة المستخدمين',
                    style: TextStyle(fontSize: 18, color: kWhite),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Image.asset(
                    'assets/icons/settings.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
