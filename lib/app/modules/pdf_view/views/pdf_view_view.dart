import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';

import '../controllers/pdf_view_controller.dart';

class PdfViewView extends GetView<PdfViewController> {
  const PdfViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview PDF'),
        centerTitle: true,
      ),
      body: Center(
        child: PDFView(
          filePath: controller.filePath.value,
          onError: (error) {
            printInfo(info: error.toString());
          },
          onPageError: (page, error) {
            printInfo(info: ': ${error.toString()}');
          },
          onPageChanged: (int? page, int? total) {
            printInfo(info: 'page change: /');
          },
        ),
      ),
    );
  }
}
