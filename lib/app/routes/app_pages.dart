import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pdf_view/bindings/pdf_view_binding.dart';
import '../modules/pdf_view/views/pdf_view_view.dart';
import '../modules/placement_signature/bindings/placement_signature_binding.dart';
import '../modules/placement_signature/views/placement_signature_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PDF_VIEW,
      page: () => const PdfViewView(),
      binding: PdfViewBinding(),
    ),
    GetPage(
      name: _Paths.PLACEMENT_SIGNATURE,
      page: () => const PlacementSignatureView(),
      binding: PlacementSignatureBinding(),
    ),
  ];
}
