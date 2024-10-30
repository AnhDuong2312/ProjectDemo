import 'dart:async';
import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/local_storage/local_storage.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../../services/print_service.dart';

class PrinterConfigControllerIOS extends GetxController with ControllerMixin {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> bluetoothDevices =
      List<BlueDevice>.empty(growable: true).obs;

  RxBool isScanning = false.obs;

  RxInt paperSize = 58.obs;
  RxString printerName = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final storage = LocalStorage();
    if (PrintService.shared.isInnerPrinter) {
      printerName.value = 'Inner Printer';
    } else {
      if (storage.printerName.val.isNotEmpty) {
        printerName.value = storage.printerName.val;
      } else {
        printerName.value = 'Không có máy in được chọn.';
      }
    }
    paperSize.value = storage.paperSize.val;
  }

  void _startScan() async {
    if (isScanning.value) {
      return;
    }
    isScanning.value = true;
    final devices = await _bluePrintPos.scan();
    bluetoothDevices.addAll(devices);
    isScanning.value = false;
  }

  void restartScan() async {
    bluetoothDevices.clear();
    _startScan();
  }

  void selectDevice(BlueDevice device) {
    final storage = LocalStorage();
    storage.printerName.val = device.name.isNotEmpty ? device.name : 'unknown';
    printerName.value = device.address.isNotEmpty ? device.address : 'unknown';
    storage.printerMacAddress.val = device.address;
    Get.back();
  }

  void selectPaperSize(int size) {
    final storage = LocalStorage();
    paperSize.value = size;
    storage.paperSize.val = size;
  }

  Future<void> back() async {
    Get.back();
  }
}
