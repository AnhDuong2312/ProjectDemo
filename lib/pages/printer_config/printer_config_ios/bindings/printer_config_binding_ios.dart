import 'package:get/get.dart';
import '../presentation/controllers/printer_config_controller_ios.dart';

class PrinterConfigBindingIOS extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrinterConfigControllerIOS());
  }
}
