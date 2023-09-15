import 'package:final_project/app_views/sender/views/widgets/sender_item.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';

class SenderList extends StatelessWidget {
  const SenderList({Key? key, required this.senders, required this.onTapSender})
      : super(key: key);
  final List<Sender> senders;
  final void Function(Sender sender) onTapSender;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => InkWell(
        onTap: () => onTapSender(senders[index]),
        child: SenderItem(
          sender: senders[index],
        ),
      ),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: senders.length,
    );
  }
}
