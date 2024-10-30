import 'package:get/get.dart';

import '../../../feature_electronic_ticket/render_pdf_scan/data/render_pdf_provider.dart';
import '../../../feature_electronic_ticket/render_pdf_scan/data/render_pdf_repository.dart';
import '../../../feature_electronic_ticket/render_pdf_scan/domain/adapter/render_pdf_adapter.dart';
import '../presentation/controllers/custom_invoice_preview_controller.dart';

class CustomInvoicePreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RenderPdfProvider());
    Get.lazyPut<IRenderPdfRepository>(
        () => RenderPdfRepository(provider: Get.find()));
    Get.lazyPut(() => CustomInvoicePreviewController(Get.find()));
  }
}
