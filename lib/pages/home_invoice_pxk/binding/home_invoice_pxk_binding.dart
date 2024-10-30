import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_electronic_ticket/render_pdf_scan/data/render_pdf_provider.dart';
import 'package:icorp_print_ticket/pages/feature_electronic_ticket/render_pdf_scan/domain/adapter/render_pdf_adapter.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_invoice/presentation/controllers/petroleum_invoice_controller.dart';
import '../../feature_electronic_ticket/list_type_ticket/data/series_provider.dart';
import '../../feature_electronic_ticket/list_type_ticket/data/series_repository.dart';
import '../../feature_electronic_ticket/list_type_ticket/domain/adapter/series_adapter.dart';
import '../../feature_electronic_ticket/render_pdf_scan/data/render_pdf_repository.dart';
import '../../feature_invoice_pxk/tab_dslog/data/ds_log_provider.dart';
import '../../feature_invoice_pxk/tab_dslog/data/ds_log_repository.dart';
import '../../feature_invoice_pxk/tab_dslog/data/petroleum_type_provider.dart';
import '../../feature_invoice_pxk/tab_dslog/data/petroleum_type_repository.dart';
import '../../feature_invoice_pxk/tab_dslog/presentation/controllers/ds_log_controller.dart';
import '../../feature_invoice_pxk/tab_invoice/data/petroleum_invoice_provider.dart';
import '../../feature_invoice_pxk/tab_invoice/data/petroleum_invoice_repository.dart';
import '../../feature_invoice_pxk/tab_petroleum/data/tab_petroleum_provider.dart';
import '../../feature_invoice_pxk/tab_petroleum/data/tab_petroleum_repository.dart';
import '../../feature_invoice_pxk/tab_petroleum/domain/adapter/tab_petroleum_adapter.dart';
import '../../feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';
import '../presentation/controller/home_invoice_pxk_controller.dart';

class HomeInvoicePxkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeInvoicePxkController());

    /// binding tab petroleum
    Get.lazyPut(() => TabPetroleumController(Get.find(), Get.find()));
    Get.lazyPut<ITabPetroleumProvider>(() => TabPetroleumProvider());
    Get.lazyPut<ITabPetroleumRepository>(
        () => TabPetroleumRepository(provider: Get.find()));

    /// binding series
    Get.lazyPut<ISeriesProvider>(() => SeriesProvider());
    Get.lazyPut<ISeriesRepository>(
        () => SeriesRepository(provider: Get.find()));

    // binding ds log tab
    Get.lazyPut<IPetroleumTypeProvider>(() => PetroleumTypeProvider());
    Get.lazyPut<IPetroleumTypeRepository>(
        () => PetroleumTypeRepository(provider: Get.find()));
    Get.lazyPut<IDSLogProvider>(() => DSLogProvider());
    Get.lazyPut<IDSLogRepository>(() => DSLogRepository(provider: Get.find()));

    Get.lazyPut(() => DSLogController(Get.find(), Get.find()));

    // binding invoice tab
    Get.lazyPut<IPetroleumInvoiceProvider>(() => PetroleumInvoiceProvider());
    Get.lazyPut<IPetroleumInvoiceRepository>(
        () => PetroleumInvoiceRepository(provider: Get.find()));
    Get.lazyPut(() => PetroleumInvoiceController(Get.find(), Get.find()));
  }
}
