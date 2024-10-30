import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

class PreviewPdfController extends GetxController {
  // final pdfController = PdfController(
  //     document: PdfDocument.openAsset('assets/init_document.pdf'));
  late PdfController pdfController;
  @override
  void onInit() {
    final filePath = Get.arguments["file_path"];
    pdfController = PdfController(document: PdfDocument.openFile(filePath));
    super.onInit();
  }

  void back() {
    Get.back();
  }
}
