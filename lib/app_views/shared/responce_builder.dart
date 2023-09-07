import "package:final_project/app_views/shared/custom_sized_box.dart";
import "package:final_project/core/util/api_response.dart";
import "package:flutter/material.dart";

class ResponseBuilder<T> extends StatelessWidget {
  final ApiResponse<T> response;
  final Widget Function(BuildContext context, String? e)? onError;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context, T data, String? message)?
      onComplete;
  const ResponseBuilder(
      {Key? key,
      required this.response,
      this.onError,
      this.onLoading,
      required this.onComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response.status == ApiStatus.ERROR && onError != null) {
      return onError!(context, response.message);
    } else if (response.status == ApiStatus.LOADING && onLoading != null) {
      return onLoading!(context);
    } else if (onComplete != null && response.data != null) {
      return onComplete!(context, response.data as T, response.message);
    } else {
      return const SSizedBox();
    }
  }
}
