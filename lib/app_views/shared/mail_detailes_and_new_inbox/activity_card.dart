import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  static const String id = "/activityCard";

  const ActivityCard({super.key});

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(

          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: 24),
          height: 78,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12, // Image radius
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Hussam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Today, 11:00 AM',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text(
                      'The issue transferred to AAAA',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
