
import 'package:get/get.dart';

import '../data/render_pdf_provider.dart';
import '../data/render_pdf_repository.dart';
import '../domain/adapter/render_pdf_adapter.dart';
import '../presentation/controllers/render_pdf_scan_controller.dart';

class RenderPdfScanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RenderPdfScanController(Get.find()));

    Get.lazyPut(() => RenderPdfProvider());
    Get.lazyPut<IRenderPdfRepository>(() => RenderPdfRepository(provider: Get.find()));
  }

}