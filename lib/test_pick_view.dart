import 'dart:io';

import 'package:final_project/core/util/image_picker.dart';
import 'package:final_project/features/current_user/repo/current_user_repo.dart';
import 'package:flutter/material.dart';

class PickView extends StatefulWidget {
  const PickView({Key? key}) : super(key: key);

  @override
  State<PickView> createState() => _PickViewState();
}

class _PickViewState extends State<PickView> {
  File? file;
  List<File> files = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                CurrentUserRepository().updateUser('mo shuqair', file?.path);
              },
              icon: Icon(Icons.api))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (file != null) Expanded(child: Image.file(file!)),
          if (files.isNotEmpty)
            Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Image.file(files[index]);
                    },
                    separatorBuilder: (_, index) => SizedBox(
                          width: 8,
                        ),
                    itemCount: files.length)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    pickGelleryImage().then((value) {
                      if (value != null) {
                        file = File(value.path);
                        print(file.toString());
                        setState(() {});
                      }
                    });
                  },
                  icon: Icon(Icons.image)),
              IconButton(
                  onPressed: () {
                    pickCameraImage().then((value) {
                      if (value != null) {
                        file = File(value.path);
                        print(file.toString());
                        setState(() {});
                      }
                    });
                  },
                  icon: Icon(Icons.camera)),
              TextButton(
                  onPressed: () {
                    pickMullImage().then((value) {
                      files = value.map((e) => File(e.path)).toList();
                      print(file.toString());
                      setState(() {});
                    });
                  },
                  child: Text("Multi")),
            ],
          )
        ],
      ),
    );
  }
}
