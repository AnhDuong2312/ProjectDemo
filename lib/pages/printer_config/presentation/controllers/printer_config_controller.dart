import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/local_storage/local_storage.dart';
import 'package:icorp_print_ticket/services/auth_service.dart';

import '../../../../common/mixins/controller_mixin.dart';
import '../../../../services/print_service.dart';

class PrinterConfigController extends GetxController with ControllerMixin {
  FlutterBluetoothSerial bluetoothSerial = FlutterBluetoothSerial.instance;

  List<BluetoothDevice> bluetoothDevices =
      List<BluetoothDevice>.empty(growable: true).obs;
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
    initDevices();
  }

  void initDevices() async {
    final devices = await bluetoothSerial.getBondedDevices();
    bluetoothDevices.addAll(devices);
  }

  void _startScan() async {
    bool? enable = await bluetoothSerial.isEnabled;
    var isEnabled = true;
    if (enable == null) {
      isEnabled = false;
    } else {
      isEnabled = enable;
    }
    if (!isEnabled) {
      showErrorAlert('Bật bluetooth để quét các thiết bị.', () {
        Get.back();
      });
      return;
    }
    if (isScanning.value) {
      return;
    }
    isScanning.value = true;
    final devices = await bluetoothSerial.getBondedDevices();
    bluetoothDevices.addAll(devices);
    isScanning.value = false;
  }

  void restartScan() async {
    bluetoothDevices.clear();
    _startScan();
  }

  void selectDevice(BluetoothDevice device) {
    final storage = LocalStorage();
    final deviceName = device.name != null ? device.name! : 'unknown';
    storage.printerName.val = deviceName.isNotEmpty ? deviceName : 'unknown';
    printerName.value = deviceName.isNotEmpty ? deviceName : 'unknown';
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
