// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:xignature_test/app/helper/common_function.dart';
import 'package:xignature_test/app/routes/app_pages.dart';

class PlacementSignatureController extends GetxController {
  Rx<Offset> offset = Offset(Get.width / 2, Get.height / 2).obs;
  RxString filePath = "".obs;
  RxInt activePage = 0.obs;
  RxBool isPlacement = false.obs;

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

  onDragImage(double x, double y) {
    offset.value = Offset(x, y);
    printInfo(info: x.toString());
  }

  onPageChanged(int page) {
    activePage.value = page;
  }

  onChangeIsPlacement() {
    isPlacement.value = !isPlacement.value;
  }

  onSaveFile() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var statusStorage = PermissionStatus.granted;
    var statusAccessMediaLocation = PermissionStatus.granted;
    var statusManageExternalStorage = PermissionStatus.granted;

    if (androidInfo.version.sdkInt >= 33) {
      statusAccessMediaLocation = await Permission.accessMediaLocation.request();
      statusManageExternalStorage = await Permission.manageExternalStorage.request();
    } else {
      statusStorage = await Permission.storage.request();
    }

    if (statusStorage == PermissionStatus.granted &&
        statusAccessMediaLocation == PermissionStatus.granted &&
        statusManageExternalStorage == PermissionStatus.granted) {
      CommonFunction.loadingShow();
      List<Directory>? directory = await getExternalStorageDirectories(type: StorageDirectory.documents);
      if (directory != null) {
        printInfo(info: "Start Save");
        ByteData bytes = await rootBundle.load('assets/signature.png');
        List<int> values = bytes.buffer.asUint8List();
        final PdfDocument document = PdfDocument(inputBytes: File(filePath.value).readAsBytesSync());
        final PdfBitmap image = PdfBitmap(values);
        document.pages[activePage.value].graphics.drawImage(
          image,
          Rect.fromLTWH(
            offset.value.dx,
            offset.value.dy,
            64,
            64,
          ),
        );
        String fileName = "${DateTime.now().millisecondsSinceEpoch}.pdf";
        String path = "/storage/emulated/0/$fileName";
        File fileDef = File(path);
        await fileDef.create(recursive: true);
        await fileDef.writeAsBytes(await document.save());
        CommonFunction.snackbarHelper(
          message: "File berhasil disimpan di 'Penyimpanan Internal/$fileName'",
          isSuccess: true,
        );
        isPlacement.value = false;
        printInfo(info: "End Save : $path");
        document.dispose();
        CommonFunction.loadingHide();
        Get.offNamed(Routes.PDF_VIEW, arguments: path);
      }
      CommonFunction.loadingHide();
    } else if (statusStorage == PermissionStatus.denied &&
        statusAccessMediaLocation == PermissionStatus.denied &&
        statusManageExternalStorage == PermissionStatus.denied) {
      CommonFunction.snackbarHelper(
        message: "Tolong berikan akses penyimpanan pada perangkat anda",
        isSuccess: false,
      );
    } else {
      CommonFunction.snackbarHelper(
        message: "Tolong berikan akses penyimpanan pada perangkat anda",
        isSuccess: false,
      );
      await openAppSettings();
    }
  }
}
