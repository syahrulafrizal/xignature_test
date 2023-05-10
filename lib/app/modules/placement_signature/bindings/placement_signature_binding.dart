import 'package:get/get.dart';

import '../controllers/placement_signature_controller.dart';

class PlacementSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlacementSignatureController>(
      () => PlacementSignatureController(),
    );
  }
}
