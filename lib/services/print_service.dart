import 'dart:typed_data';

import 'package:get/get.dart';

import 'printing.dart';

class PrintService extends GetxService {
  static PrintService get shared => Get.find();
  late Printing _printing;
  String? sunmiSerial;
  @override
  void onInit() {
    _printing = Printing();
    super.onInit();
  }

  bool get isInnerPrinter => _printing.isPrintInner;

  Future<PrintCondition> checkPrintCondition(bool isOuterSelected) async {
    return _printing.checkPrintCondition(isOuterSelected);
  }

  Future<PrintingState> printImages(List<Uint8List> listData, int paperSize,
      String? name, String? address) async {
    return _printing.printImages(listData, paperSize, name, address);
  }

  void setPrinterIsInner(bool isInner) {
    _printing.setPrinterIsInner(isInner);
  }
}
