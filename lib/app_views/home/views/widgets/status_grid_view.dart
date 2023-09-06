import 'dart:ffi';

import 'package:final_project/app_views/shared/responce_builder.dart';
import 'package:final_project/core/util/colors.dart';
import 'package:final_project/app_views/home/views/widgets/status_box.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/util/styles.dart';
import 'package:provider/provider.dart';

import '../../../../features/status/provider/status_provider.dart';

class StatusGridView extends StatefulWidget {
  const StatusGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatusGridView> createState() => _StatusGridViewState();
}

class _StatusGridViewState extends State<StatusGridView> {
  List<String> statusTextsList = [
    "Inbox",
    "Pending",
    "In Progress",
    "Completed"
  ];
  List<Color> statusColorsList = [kInbox, kPending, kLightSub, kCompleted];
  List<int?>? statusNumberList = [];

  late bool isLoading = true; //for shimmer

  @override
  void initState() {

    getData();
    super.initState();
  }

    Future<void> getData() async{
    await StatusProvider().getAllStatus(false).then((value) => value);

    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      statusNumberList!.addAll([9, 9, 9, 9]);
      setState(() {});
    });
   
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return  Consumer<StatusProvider>(builder: (_,provider, child){
      return ResponseBuilder(response: provider.allStatus, onComplete: (_,data,message){
        return GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: deviceSize.width > 400 ? 1.5 / 0.5 : 1.5 / 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return StatusClass(
              statusColor: Color(int.parse(data!.statuses![index]!.color?? "")) ,
              statusText: data!.statuses![index]!.name?? "",
              statusNumber: data!.statuses!.isEmpty
                  ? Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: kUnselect,
                  shape: BoxShape.circle,
                ),
              )
                  : Text(
                "${data.statuses![index].mailsCount}",
                style: kStatusNumberTextStyle,
              ),
            );
          },
        );
      });
    }) ;
  }
}


