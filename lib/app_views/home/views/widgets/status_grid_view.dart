import 'package:final_project/core/util/colors.dart';
import 'package:final_project/app_views/home/views/widgets/status_box.dart';
import 'package:flutter/material.dart';
import 'package:final_project/core/util/styles.dart';

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

  void getData() {
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      statusNumberList!.addAll([9, 9, 9, 9]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
          statusColor: statusColorsList[index],
          statusText: statusTextsList[index],
          statusNumber: statusNumberList!.isEmpty
              ? Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: kUnselect,
                    shape: BoxShape.circle,
                  ),
                )
              : Text(
                  "${statusNumberList![index]}",
                  style: kStatusNumberTextStyle,
                ),
        );
      },
    );
  }
}
