// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class PdfViewController extends GetxController {
  RxString filePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    filePath.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
