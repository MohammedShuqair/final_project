import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as i;
import 'package:http/http.dart' as http;

extension FirstCapital on String {
  String firstCapital() {
    List<String> words = trim().split(' ');
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
  void listMail(List<Mail> mails, void Function(Mail mail) onTap) {
    List<Widget> mailCards = [];

    for (int i = 0; i < mails.length; i++) {
      if (i == mails.length - 1) {
        mailCards.add(MailCard(
          index: i + 1,
          mail: mails[i],
          onTap: () {
            onTap(mails[i]);
          },
        ));
      } else {
        mailCards.add(Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MailCard(
              index: i + 1,
              onTap: () {
                onTap(mails[i]);
              },
              mail: mails[i],
            ),
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

extension IsValidUrl on String {
  Future<bool> isImageValid() async {
    try {
      final response = await http.head(Uri.parse(this));
      return response.statusCode == 200;
    } catch (s) {
      print('IsValidUrl extension :$s');
      return false;
    }
  }
}

extension DateFormat on String {
  String formatArriveTime() {
    DateTime? arriveTime = DateTime.tryParse(this);
    if (arriveTime != null) {
      // arriveTime = arriveTime.add(const Duration(hours: 3));
      var now = DateTime.now();
      var formatterDate = i.DateFormat('d - M - yyyy');
      var formatterTime = i.DateFormat.Hm();
      if (arriveTime.year.compareTo(now.year) == 0 &&
          arriveTime.month.compareTo(now.month) == 0) {
        if (arriveTime.day.compareTo(now.day) == 0) {
          if (now.hour == arriveTime.hour) {
            if (now.minute == arriveTime.minute) {
              return "${now.second - arriveTime.second} ${'seconds'.tr()}";
            } else {
              return "${now.minute - arriveTime.minute} ${'min ago'.tr()}";
            }
          } else {
            if (now.hour - 1 == arriveTime.hour) {
              if (now.minute + (60 - arriveTime.minute) < 60) {
                return "${now.minute + (60 - arriveTime.minute)} ${'min ago'.tr()}";
              } else {
                return "${((now.minute + (60 - arriveTime.minute)) / 60).floor()} ${'hour'.tr()},${(now.minute + (60 - arriveTime.minute)) % 60} ${'min ago'.tr()}";
              }
            } else {
              if ((now.minute - arriveTime.minute).isNegative) {
                return "${(now.hour - 1) - arriveTime.hour} ${'hour'.tr()},${(now.minute + 60) - arriveTime.minute} ${'min ago'.tr()}";
              } else {
                return "${now.hour - arriveTime.hour} ${'hour'.tr()},${now.minute - arriveTime.minute} ${'min ago'.tr()}";
              }
            }
          }
        } else {
          if (now.day - 1 == arriveTime.day) {
            return "${'Yesterday'.tr()} ${formatterTime.format(arriveTime)}";
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
