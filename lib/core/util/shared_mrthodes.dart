import 'dart:convert';

import 'package:final_project/app_views/mail_details/details_provider/details_provider.dart';
import 'package:final_project/app_views/mail_details/views/mail_details_screen.dart';
import 'package:final_project/app_views/shared/alert.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void handelResponseStatus(ApiStatus status, BuildContext context,
    {String? message, void Function()? onComplete}) {
  if (status == ApiStatus.LOADING) {
    showAlert(context, message: message ?? 'logging...', isError: false);
  } else if (status == ApiStatus.ERROR) {
    showAlert(context, message: message ?? 'error');
  } else {
    showAlert(context, message: message ?? 'done successfully', isError: false);
    if (onComplete != null) {
      onComplete();
    }
  }
}

bool testPasswordLength(String? value) => value!.length < 6;

bool testEmailValidation(String? value) => value?.contains('@') ?? true;

bool testEmpty(String? value) => value?.isEmpty ?? true;

bool testNull(String? value) => value == null;

User getUser() {
  return User.fromMap(jsonDecode(SharedHelper().getData(key: 'user')));
}

void showMailDetailsSheet(
    BuildContext context, Mail mail, Future Function() onDone) {
  showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 1.sh - 60.h),
      clipBehavior: Clip.hardEdge,
      builder: (c2) {
        return ChangeNotifierProvider(
          create: (context) => DetailsProvider(mail),
          child: const MailDetailsView(),
        );
      }).then((value) => value ?? false ? onDone() : null);
}

Map<String, List<Mail>> mailsToCategoriesMap(List<Mail> mails) {
  Map<String, List<Mail>> data = {};
  data.filterMailsByCategory(defaultCategories, mails);
  data.removeWhere((key, value) => value.isEmpty);
  data.sortMailMap();
  return data;
}
