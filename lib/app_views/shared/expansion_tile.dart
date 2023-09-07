import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/core/util/edited_expansion_tile.dart' as ed;
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/util/colors.dart';
import '../../core/util/styles.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget(
      {Key? key, required this.title, required this.count, required this.mails})
      : super(key: key);
  final String title;
  final int count;
  final List<Mail> mails;

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  bool isClose = true;

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() {
    //get on children
  }

  @override
  Widget build(BuildContext context) {
    return ed.ExpansionTile(
        tilePadding: EdgeInsets.zero,
        // how to animation
        shape: Border.all(color: Colors.transparent),
        onExpansionChanged: (_) {
          setState(() {
            isClose = !isClose;
          });
        },
        title: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(
            widget.title,
            style: tagTitleTextStyle,
          ),
        ),
        trailing: isClose
            ? Row(
                //Question in design
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.count}',
                    style: kNumArrowInExpansion,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                    color: kSubText,
                  ),
                ],
              )
            : const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: kLightSub,
                size: 24,
              ),
        children: listMail() //here pass children
        );
  }

  List<Widget> listMail() {
    List<Widget> mailCards = [];
    for (int i = 0; i < widget.mails.length; i++) {
      if (i == widget.mails.length - 1) {
        mailCards.add(MailCard(
            status: widget.mails[i].status?.color ?? '',
            organizationName: widget.mails[i].sender?.name ?? '',
            lastDate: widget.mails[i].createdAt ?? '',
            subject: widget.mails[i].subject ?? '',
            body: widget.mails[i].description ?? '',
            tags: widget.mails[i].tags?.map((e) => e.name ?? '').toList() ?? [],
            images: widget.mails[i].attachments
                    ?.map((e) => e.image ?? '')
                    .toList() ??
                []));
      } else {
        mailCards.add(Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MailCard(
                status: widget.mails[i].status?.color ?? '',
                organizationName: widget.mails[i].sender?.name ?? '',
                lastDate: widget.mails[i].createdAt ?? '',
                subject: widget.mails[i].subject ?? '',
                body: widget.mails[i].description ?? '',
                tags: widget.mails[i].tags?.map((e) => e.name ?? '').toList() ??
                    [],
                images: widget.mails[i].attachments
                        ?.map((e) => e.image ?? '')
                        .toList() ??
                    []),
            Divider(
              indent: 23.w,
            ),
          ],
        ));
      }
    }
    return mailCards;
  }
}
