

import 'package:final_project/app_views/home/views/home_screen.dart';
import 'package:final_project/app_views/shared/custom_sized_box.dart';
import 'package:final_project/app_views/users_management/screens/create_user/create_user.dart';
import 'package:flutter/material.dart';
class UsersManagement extends StatelessWidget {
  static const id = "user-management";
  const UsersManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, HomeView.id);
        }, icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("User Management"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search),),

        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: Icon(Icons.group),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("Get all users"),
            ),
            const SSizedBox(height: 16,),
            ListTile(
              onTap: (){
                Navigator.pushReplacementNamed(context, CreateUserScreen.id);
              },
              leading: const Icon(Icons.add_circle_outlined),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: const Text("create users"),
            ),

          ],
        ),
      ),
    );
  }
}
