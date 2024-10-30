import 'package:get/get.dart';

import '../presentation/pdf_preview_controller.dart';

class PdfPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreviewPdfController());
  }
}
