// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonFunction {
  static loadingShow() {
    return Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  static loadingHide() {
    if (Get.isDialogOpen ?? false) Navigator.of(Get.overlayContext!).pop();
  }

  static snackbarHelper(
      {String? title,
      String? message,
      bool isSuccess = true,
      void Function()? mainButtonOnPressed,
      Widget? mainButton,
      Duration duration = const Duration(seconds: 4)}) {
    return Get.rawSnackbar(
      messageText: Text(
        message ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ).paddingOnly(right: 16),
      backgroundColor: isSuccess ? const Color(0xFF29823B) : const Color(0xFFDC2020),
      duration: duration,
      barBlur: 8.0,
      borderRadius: 10,
      padding: const EdgeInsets.symmetric(vertical: 20),
      mainButton: mainButtonOnPressed == null
          ? null
          : TextButton(
              onPressed: mainButtonOnPressed,
              child: mainButton ??
                  const Text(
                    'Lihat',
                    style: TextStyle(color: Colors.white),
                  ),
            ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 30),
      icon: Icon(
        isSuccess ? Icons.check_circle_rounded : Icons.warning_rounded,
        color: Colors.white,
        size: 24,
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 10),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ],
    );
  }
}
