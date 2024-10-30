import 'package:get/get.dart';
import '../../render_pdf_scan/data/render_pdf_provider.dart';
import '../../render_pdf_scan/data/render_pdf_repository.dart';
import '../../render_pdf_scan/domain/adapter/render_pdf_adapter.dart';
import '../data/serial_provider.dart';
import '../data/serial_repository.dart';
import '../domain/adapter/serial_adapter.dart';
import '../presentation/controllers/detail_ticket_controller.dart';

class DetailTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailTicketController(Get.find(), Get.find()));

    Get.lazyPut<ISerialProvider>(() => SerialProvider());
    Get.lazyPut<ISerialRepository>(
        () => SerialRepository(provider: Get.find()));

    Get.lazyPut(() => RenderPdfProvider());
    Get.lazyPut<IRenderPdfRepository>(
        () => RenderPdfRepository(provider: Get.find()));
  }
}
