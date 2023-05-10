import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';

import '../controllers/placement_signature_controller.dart';

class PlacementSignatureView extends GetView<PlacementSignatureController> {
  const PlacementSignatureView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Placement Signature'),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
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
                  controller.onPageChanged(page ?? 0);
                },
              ),
            ),
            if (controller.isPlacement.value)
              Positioned(
                left: controller.offset.value.dx,
                top: controller.offset.value.dy,
                child: Draggable(
                  childWhenDragging: Container(),
                  feedback: Column(
                    children: [
                      Image.asset(
                        "assets/signature.png",
                        height: 64,
                        width: 64,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  onDragEnd: (details) {
                    controller.onDragImage(
                      details.offset.dx,
                      details.offset.dy - AppBar().preferredSize.height - MediaQuery.of(context).viewPadding.top,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/signature.png",
                        height: 64,
                        width: 64,
                        fit: BoxFit.contain,
                      ),
                      Text("X : ${controller.offset.value.dx.toStringAsFixed(2)}"),
                      Text("Y : ${controller.offset.value.dy.toStringAsFixed(2)}"),
                      TextButton(
                        onPressed: () {
                          controller.onChangeIsPlacement();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFD50020),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "tag",
          onPressed: () async {
            if (!controller.isPlacement.value) {
              controller.onChangeIsPlacement();
            } else {
              controller.onSaveFile();
            }
          },
          label: Text(
            controller.isPlacement.value ? "Save File" : "Add Signature",
          ),
          icon: Icon(
            controller.isPlacement.value ? Icons.save : Icons.edit,
          ),
        ),
      ),
    );
  }
}
