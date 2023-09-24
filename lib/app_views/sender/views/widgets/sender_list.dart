import 'package:final_project/app_views/sender/views/widgets/sender_item.dart';
import 'package:final_project/app_views/shared/shimmers/custom_shimmer.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:flutter/material.dart';

class SenderList extends StatelessWidget {
  const SenderList(
      {Key? key,
      required this.senders,
      this.onTapSender,
      this.isShimmer = false,
      this.controller,
      this.onTapDelete,
      this.onTapEdit})
      : super(key: key);
  final List<Sender> senders;
  final void Function(Sender sender)? onTapSender;
  final bool isShimmer;
  final ScrollController? controller;
  final void Function(Sender sender)? onTapDelete;
  final void Function(Sender sender)? onTapEdit;

  @override
  Widget build(BuildContext context) {
    if (isShimmer) {
      return ListView.separated(
        controller: controller,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => onTapSender!(senders[index]),
            child: CustomShimmer(
              child: SenderItem(
                sender: senders[index],
              ),
            ),
          );
        },
        separatorBuilder: (_, index) => const Divider(),
        itemCount: senders.length,
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => InkWell(
          onTap: () => onTapSender!(senders[index]),
          child: SenderItem(
            onTapEdit:
                onTapEdit == null ? null : () => onTapEdit!(senders[index]),
            onTapDelete:
                onTapDelete == null ? null : () => onTapDelete!(senders[index]),
            sender: senders[index],
          ),
        ),
        separatorBuilder: (_, index) => const Divider(),
        itemCount: senders.length,
      );
    }
  }
}
