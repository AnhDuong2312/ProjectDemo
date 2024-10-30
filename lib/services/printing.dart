import 'dart:convert';
import 'dart:typed_data';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/connection_status.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

enum PrintCondition {
  printNow,
  noPrinter,
  bluetoothOff,
}

enum PrintingState {
  success,
  disconnect,
  nodata,
}

class Printing {
  // using BluePrintPos for scanning and print (instead of BluetoothPrint - because it can print iOS)
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  BlueDevice? _selectedDevice;

  // BluetoothPrint for convert data and filter image before printing
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  // filter image before print: only use for image
  final int _graphicFilter = 6;

  late bool isPrintInner;

  Printing();

  Future<ConnectionStatus> _connectPrinter(String name, String address) async {
    if (_selectedDevice == null) {
      await _bluePrintPos.disconnect();
      _selectedDevice = BlueDevice(name: name, address: address);
      return await _bluePrintPos.connect(_selectedDevice!);
    } else {
      if (_selectedDevice!.name != name) {
        // disconnect old device
        await _bluePrintPos.disconnect();
        // and connect new device
        _selectedDevice = BlueDevice(name: name, address: address);
        return await _bluePrintPos.connect(_selectedDevice!);
      }
    }
    if (!_bluePrintPos.isConnected) {
      return await _bluePrintPos.connect(_selectedDevice!);
    }
    return ConnectionStatus.connected;
  }

  Future<PrintingState> printImages(List<Uint8List> listData, int paperSize,
      String? name, String? address) async {
    if (isPrintInner) {
      return await _printImagesWithSunmiInner(listData, paperSize);
    } else {
      return await _printImagesWithOuter(listData, paperSize, name!, address!);
    }
  }

  Future<PrintingState> _printImagesWithOuter(List<Uint8List> listData,
      int paperSize, String name, String address) async {
    List<LineText> list = [];
    Map<String, dynamic> config = {
      "graphicFilter": _graphicFilter,
      "paperWidth": paperSize
    };
    for (var i = 0; i < listData.length; i++) {
      final data = listData[i];
      final imageData = List<int>.from(data);
      String base64Image = base64Encode(imageData);
      list.add(LineText(
          type: LineText.TYPE_IMAGE,
          content: base64Image,
          align: LineText.ALIGN_CENTER,
          linefeed: 1));
    }
    final printData = await bluetoothPrint.mapToReceipt(list, config);
    if (printData != null) {
      final connectResult = await _connectPrinter(name, address);
      if (connectResult != ConnectionStatus.connected) {
        return PrintingState.disconnect;
      }

      List<int> bytes = [];
      bytes += printData;
      await _bluePrintPos.printBytes(bytes);
      return PrintingState.success;
    }
    return PrintingState.nodata;
  }

  Future<PrintingState> _printImagesWithSunmiInner(
      List<Uint8List> listData, int paperSize) async {
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.startTransactionPrint(true);
    for (var data in listData) {
      await SunmiPrinter.printImage(data, _graphicFilter, paperSize);
    }
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
    return PrintingState.success;
  }

  Future<PrintCondition> checkPrintCondition(bool isOuterSelected) async {
    if (isPrintInner) {
      return PrintCondition.printNow;
    }
    if (!isOuterSelected) {
      return PrintCondition.noPrinter;
    }
    final isOn = await _bluePrintPos.isOn();
    if (isOn) {
      return PrintCondition.printNow;
    }
    return PrintCondition.bluetoothOff;
  }

  void setPrinterIsInner(bool isInner) {
    isPrintInner = isInner;
  }
}
