import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/printer_config/presentation/controllers/printer_config_controller.dart';

class PrinterConfigBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PrinterConfigController());
  }

}