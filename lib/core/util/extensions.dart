import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as i;

extension FirstCapital on String {
  String firstCapital() {
    List<String> words = split(' ');
    List<String> result = [];
    words.forEach((word) {
      result.add(word[0].toUpperCase() + word.substring(1));
    });
    return result.join(' ');
  }
}

extension FilterCategoryMails on Map {
  void filterMailsByCategory(List<Category> categories, List<Mail> mails) {
    Map<String, List<Mail>> data = {};
    categories.forEach((category) {
      data.addAll({'${category.name}': []});
      mails.forEach((mail) {
        if (mail.sender?.categoryId == category.id.toString()) {
          data['${category.name}']?.add(mail);
        }
      });
    });
    addAll(data);
  }
}

extension SortCategoryMails on Map<String, List<Mail>> {
  void sortMailMap() {
    //From Chat GPT
    // Convert the map into a list of key-value pairs
    List<MapEntry<String, List<Mail>>> entryList = entries.toList();
    // Sort the list in descending order based on the keys
    entryList.sort((a, b) => b.value.length.compareTo(a.value.length));

    // Create a new map from the sorted list
    Map<String, List<Mail>> sortedMap = Map.fromEntries(entryList);
    clear();
    addAll(sortedMap);
  }
}

extension ListMail on List {
  void listMail(List<Mail> mails) {
    List<Widget> mailCards = [];

    for (int i = 0; i < mails.length; i++) {
      if (mails[i].id == 67) {
        print(mails[i].createdAt);
        print('createdAt ${DateTime.tryParse(mails[i].createdAt ?? "")}');
        print('archiveDate ${DateTime.tryParse(mails[i].archiveDate ?? "")}');
        print('now ${DateTime.now()}');
      }
      if (i == mails.length - 1) {
        mailCards.add(MailCard(
            status: mails[i].status?.color ?? '',
            organizationName: mails[i].sender?.name ?? '',
            lastDate: mails[i].createdAt ?? '',
            subject: mails[i].subject ?? '',
            body: mails[i].description ?? '',
            tags: mails[i].tags?.map((e) => e.name ?? '').toList() ?? [],
            images: mails[i].attachments?.map((e) => e.image ?? '').toList() ??
                []));
      } else {
        mailCards.add(Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MailCard(
                status: mails[i].status?.color ?? '',
                organizationName: mails[i].sender?.name ?? '',
                lastDate: mails[i].createdAt ?? '',
                subject: mails[i].subject ?? '',
                body: mails[i].description ?? '',
                tags: mails[i].tags?.map((e) => e.name ?? '').toList() ?? [],
                images:
                    mails[i].attachments?.map((e) => e.image ?? '').toList() ??
                        []),
            Divider(
              height: 22.h,
              indent: 23.w,
            ),
          ],
        ));
      }
    }
    addAll(mailCards);
  }
}

extension TotalLength on List<List> {
  int totalLength2D() {
    return fold(0, (int previousLength, List innerList) {
      return previousLength + innerList.length;
    });
  }
}

extension DateFormat on String {
  String formatArriveTime() {
    DateTime? arriveTime = DateTime.tryParse(this);
    if (arriveTime != null) {
      arriveTime = arriveTime.add(const Duration(hours: 3));
      var now = DateTime.now();
      var formatterDate = i.DateFormat('d - M - yyyy');
      var formatterTime = i.DateFormat.Hm();
      if (arriveTime.year.compareTo(now.year) == 0 &&
          arriveTime.month.compareTo(now.month) == 0) {
        if (arriveTime.day.compareTo(now.day) == 0) {
          if (now.hour == arriveTime.hour) {
            if (now.minute == arriveTime.minute) {
              return "${now.second - arriveTime.second} seconds";
            } else {
              return "${now.minute - arriveTime.minute} min ago";
            }
          } else {
            if (now.hour - 1 == arriveTime.hour) {
              if (now.minute + (60 - arriveTime.minute) < 60) {
                return "${now.minute + (60 - arriveTime.minute)} min ago";
              } else {
                return "${((now.minute + (60 - arriveTime.minute)) / 60).floor()} hour,${(now.minute + (60 - arriveTime.minute)) % 60} min ago";
              }
            } else {
              if ((now.minute - arriveTime.minute).isNegative) {
                return "${(now.hour - 1) - arriveTime.hour} hour,${(now.minute + 60) - arriveTime.minute} min ago";
              } else {
                return "${now.hour - arriveTime.hour} hour,${now.minute - arriveTime.minute} min ago";
              }
            }
          }
        } else {
          if (now.day - 1 == arriveTime.day) {
            return "Yesterday ${formatterTime.format(arriveTime)}";
          } else {
            return formatterDate.format(arriveTime);
          }
        }
      } else {
        return formatterDate.format(arriveTime);
      }
    } else {
      return this;
    }
  }
}
