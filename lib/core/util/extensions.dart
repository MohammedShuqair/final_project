import 'package:final_project/app_views/shared/mail_card.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              indent: 23.w,
            ),
          ],
        ));
      }
    }
    addAll(mailCards);
  }
}
