
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendActivityBar extends StatelessWidget {
  static const String id = "/sendActivity";

  const SendActivityBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              children: [
                SizedBox(
                  width: 14,
                ),
                CircleAvatar(
                  radius: 14, // Image radius
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Add new Activity …',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/send.svg',
                  width: 32.0,
                  height: 28.0,
                ),
                SizedBox(
                  width: 14,
                ),
              ],
            )),
      ),
    );
  }
}
