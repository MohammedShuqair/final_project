import 'package:final_project/shared/widgets/alert.dart';
import 'package:final_project/core/util/api_response.dart';
import 'package:flutter/material.dart';

void handelResponseStatus(Status status, BuildContext context,
    {String? message, void Function()? onComplete}) {
  if (status == Status.LOADING) {
    showAlert(context, message: message ?? 'logging...', isError: false);
  } else if (status == Status.ERROR) {
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
