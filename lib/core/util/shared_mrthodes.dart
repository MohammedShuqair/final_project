import 'package:final_project/app_views/shared/alert.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:flutter/material.dart';

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
