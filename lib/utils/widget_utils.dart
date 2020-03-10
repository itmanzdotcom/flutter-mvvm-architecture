import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_mvvm_arch/utils/constants.dart';
import 'package:flutter_base_mvvm_arch/utils/toast.dart';

dispatchFailure(BuildContext context, dynamic e) {
  var message = e.toString();
  if (e is DioError) {
    final response = e.response;

    switch (response?.statusCode) {
      case APIError.ERROR_AUTHORIZE:
        return message = "account or password error ";
      case APIError.ERROR_FORBIDDEN:
        return message = "forbidden";
      case APIError.ERROR_NOT_FOUND:
        return message = "page not found";
      case APIError.ERROR_INTERNAL_SERVER:
        return message = "Server internal error";
      case APIError.ERROR_UPDATING_SERVER:
        return message = "Server Updating";
      default:
        if (e.error is SocketException) {
          return message = "network cannot use";
        }
        message = "Oops!!";
    }

    print("error ：" + message);
    if (context != null) {
      Toast.show(message, context, type: Toast.ERROR);
    }
  }
}
