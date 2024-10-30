import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/custom_invoice_preview/bindings/custom_invoice_preview_binding.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/custom_invoice_preview/presentation/views/custom_invoice_preview.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/pdf_preview/views/pdf_preview.dart';
import 'package:icorp_print_ticket/pages/home/bindings/home_binding.dart';
import 'package:icorp_print_ticket/pages/home/presentation/views/home.dart';
import 'package:icorp_print_ticket/pages/home_electronic_ticket/binding/home_electronic_ticket_binding.dart';
import 'package:icorp_print_ticket/pages/home_electronic_ticket/presentation/view/home_electronic_ticket.dart';
import 'package:icorp_print_ticket/pages/home_invoice_pxk/presentation/view/home_invoice_pxk.dart';
import 'package:icorp_print_ticket/pages/printer_config/presentation/views/printer_config.dart';
import '../pages/camera/licence_camera_overlay.dart';
import '../pages/feature_electronic_ticket/detail_ticket/binding/detail_ticket_binding.dart';
import '../pages/feature_electronic_ticket/detail_ticket/presentation/views/detail_ticket.dart';
import '../pages/feature_electronic_ticket/render_pdf_scan/bindings/render_pdf_scan_binding.dart';
import '../pages/feature_electronic_ticket/render_pdf_scan/presentation/views/render_pdf_scan.dart';
import '../pages/feature_invoice_pxk/pdf_preview/binding/pdf_preview_binding.dart';
import '../pages/home_invoice_pxk/binding/home_invoice_pxk_binding.dart';
import '../pages/login/bindings/login_binding.dart';
import '../pages/login/presentation/views/login.dart';
import '../pages/printer_config/bindings/printer_config_binding.dart';
import '../pages/printer_config/printer_config_ios/bindings/printer_config_binding_ios.dart';
import '../pages/printer_config/printer_config_ios/presentation/views/printer_config_ios.dart';
import '../pages/start/bindings/start_binding.dart';
import '../pages/start/presentation/views/start.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.start;

  static final routes = [
    GetPage(
        name: Routes.start,
        page: () => const Start(),
        bindings: [StartBinding()]),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      bindings: [LoginBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.homeElectronicTicket,
      page: () => const HomeElectronicTicket(),
      bindings: [HomeElectronicTicketBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.ticketDetail,
      page: () => const DetailTicket(),
      bindings: [DetailTicketBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.printTicket,
      page: () => const RenderPdfScan(),
      bindings: [RenderPdfScanBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.printingConfigIOS,
      page: () => const PrinterConfigIOS(),
      bindings: [PrinterConfigBindingIOS()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.printingConfig,
      page: () => const PrinterConfig(),
      bindings: [PrinterConfigBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.cameraScanLicence,
      page: () => const LicenceCameraOverlay(),
      bindings: const [],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.home,
      page: () => const Home(),
      bindings: [HomeBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.homeInvoicePXK,
      page: () => const HomeInvoicePxk(),
      bindings: [HomeInvoicePxkBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.customInvoicePreview,
      page: () => const CustomInvoicePreview(),
      bindings: [CustomInvoicePreviewBinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.pdfPreview,
      page: () => const PdfPreview(),
      bindings: [PdfPreviewBinding()],
      transition: Transition.rightToLeft,
    ),
  ];
}
