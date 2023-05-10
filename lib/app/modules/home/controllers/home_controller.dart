// ignore_for_file: unnecessary_overrides

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:xignature_test/app/routes/app_pages.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onSelectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      printInfo(info: result.files.single.path ?? "-");
      Get.toNamed(Routes.PLACEMENT_SIGNATURE, arguments: result.files.single.path);
    }
  }
}
