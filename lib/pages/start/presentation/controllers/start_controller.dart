import 'package:get/get.dart';
import 'package:icorp_print_ticket/services/auth_service.dart';
import 'package:icorp_print_ticket/services/print_service.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../../common/local_storage/local_storage.dart';
import '../../../../routes/app_pages.dart';

class StartController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    PrintService.shared.setPrinterIsInner(false);
    // check if inner printer is sunmi
    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.serialNumber().then((String serial) {
        PrintService.shared.setPrinterIsInner(serial != 'NOT FOUND');
        PrintService.shared.sunmiSerial = serial;
      });
    });
    // if remember login and has access token -> list ticket
    final LocalStorage storage = LocalStorage();
    if (storage.isAutoLogin.val && storage.accessToken.val != "") {
      navigateToListTicket();
    } else {
      navigateToLogin();
    }
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.login);
    });
  }

  void navigateToListTicket() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.home);
    });
  }
}
