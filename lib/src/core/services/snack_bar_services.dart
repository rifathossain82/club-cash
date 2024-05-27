import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarService {
  static showSnackBar({
    required String message,
    required Color bgColor,
    int durationInSeconds = 1,
  }) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: bgColor,
          message: message,
          maxWidth: 1170,
          duration: Duration(seconds: durationInSeconds),
          snackStyle: SnackStyle.FLOATING,
          margin: const EdgeInsets.all(10),
          borderRadius: 5,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
    }
  }
}

