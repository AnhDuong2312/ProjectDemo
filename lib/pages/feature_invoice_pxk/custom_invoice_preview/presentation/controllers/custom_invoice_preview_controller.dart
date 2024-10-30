import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/utils/utils.dart';
import 'package:icorp_print_ticket/services/print_service.dart';
import 'package:icorp_print_ticket/services/printing.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/colors/colors.dart';
import '../../../../../common/local_storage/local_storage.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../feature_electronic_ticket/render_pdf_scan/domain/adapter/render_pdf_adapter.dart';
import '../../../tab_petroleum/domain/enties/system_format_number_entity.dart';
import '../views/custom_invoice_preview.dart';

class CustomInvoicePreviewController extends GetxController
    with ControllerMixin {
  final IRenderPdfRepository pdfRepository;
  static String argumentData = "data_printer_invoice";

  CustomInvoicePreviewController(this.pdfRepository);

  bool canStartPrint = false;
  final int _graphicFilter = 6;
  var screenshotController = ScreenshotController();

  var isPrinting = false.obs;
  RxString path = ''.obs;
  var nameStore = "".obs;
  var serial = "".obs;
  var taxAuthorityCode = "".obs;
  var nameProduct = "".obs;
  var unitPrice = "".obs;
  var quantity = "".obs;
  var totalUnitPriceAfterTax = "".obs;
  var numberInvoice = "".obs;
  var date = "".obs;
  var systemFormatNumber = SystemFormatNumberEntity(
          quantity: 0, unitPrice: 0, totalAmount: 0, totalCost: 0)
      .obs;
  var lookupCode = "".obs;
  int invoiceId = -1;

  //var model = SeePetroleumReceiptEntity().obs;

  @override
  void onInit() {
    receiveData();
    super.onInit();
  }

  receiveData() {
    var data = Get.arguments[argumentData];
    invoiceId = data["invoiceId"] ?? -1;
    final systemFormatNumber =
        data["systemFormatNumber"] as SystemFormatNumberEntity;
    lookupCode.value = data["lookupCode"];
    nameStore.value = data["nameStore"].toString();
    serial.value = data["serial"].toString();
    numberInvoice.value = data["numberInvoice"] ?? "";
    date.value = Utils.formatDate(DateTime.parse(data["date"]),
        formatString: "dd/MM/yyyy");
    taxAuthorityCode.value = data["taxAuthorityCode"].toString();
    nameProduct.value = data["nameProduct"].toString();
    unitPrice.value = NumberFormat("#,###.##########").format(double.parse(
        (double.parse((data["unitPrice"] * 1.1).toString()))
            .toStringAsFixed(systemFormatNumber.unitPrice)));
    quantity.value = NumberFormat("#,###.##########").format(double.parse(
        (double.parse(data["quantity"].toString()))
            .toStringAsFixed(systemFormatNumber.quantity)));
    totalUnitPriceAfterTax.value = NumberFormat("#,###.##########").format(
        double.parse((double.parse(data["totalUnitPriceAfterTax"].toString()))
            .toStringAsFixed(systemFormatNumber.totalCost)));
  }

  Future<void> processPrinting() async {
    isPrinting.value = true;
    screenshotController
        .captureFromLongWidget(const ViewReceiptToPrint(isClickLink: false),
            delay: const Duration(milliseconds: 300))
        .then((image) async {
      final tempDir = await getTemporaryDirectory();
      final File fileCurrent = await File(
              '${tempDir.path}/image${DateTime.now().toIso8601String()}.jpg')
          .create();
      fileCurrent.writeAsBytesSync(image);
      path.value = fileCurrent.path;
      showLoading();
      final storage = LocalStorage();
      final condition = await PrintService.shared
          .checkPrintCondition(storage.printerMacAddress.val.isNotEmpty);

      switch (condition) {
        case PrintCondition.printNow:
          await _print();
          hideLoading();
          break;
        case PrintCondition.noPrinter:
          navigateToPrintingConfig();
          hideLoading();
          isPrinting.value = false;
          break;
        case PrintCondition.bluetoothOff:
          hideLoading();
          showErrorAlert('Bật bluetooth để in.', () {
            Get.back();
          });
          isPrinting.value = false;
          break;
      }
    }).catchError((onError) {
      isPrinting.value = false;
      throw onError;
    });
  }

  void navigateToPrintingConfig() {
    if (GetPlatform.isAndroid) {
      Get.toNamed(Routes.printingConfig);
    } else {
      Get.toNamed(Routes.printingConfigIOS);
    }
  }

  Future<void> _print() async {
    if (path.value == "") {
      // ko co du lieu de in
      isPrinting.value = false;
      return;
    }

    final storage = LocalStorage();

    Uint8List bytes = File(path.value).readAsBytesSync();
    List<Uint8List> listData = [bytes];
    // for (var image in pdfImages) {
    //   listData.add(image.bytes);
    // }
    final result = await PrintService.shared.printImages(
        listData,
        storage.paperSize.val == 80 ? 576 : 384,
        storage.printerName.val,
        storage.printerMacAddress.val);
    switch (result) {
      case PrintingState.success:
        Future.delayed(const Duration(seconds: 1), () {
          isPrinting.value = false;
        });
        break;
      case PrintingState.disconnect:
        Get.snackbar(
          "Lỗi",
          'Có lỗi kết nối tới máy in.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
        );
        isPrinting.value = false;
        break;
      case PrintingState.nodata:
        Get.snackbar(
          "Lỗi",
          'Có lỗi dữ liệu in.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.primary,
          colorText: Colors.white,
        );
        isPrinting.value = false;
        break;
    }
  }

  Future<void> shareInvoice(String invoiceId) async {
    showLoading();
    try {
      final response = await pdfRepository.exportPdf(invoiceId);
      final filePath = await savePdf(response as Uint8List);
      Share.shareXFiles([XFile(filePath)]);
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
      Get.snackbar(
        "Lỗi",
        se.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    } on ApiError catch (ex) {
      hideLoading();
      Get.snackbar(
        "Lỗi",
        ex.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    }
  }

  Future<String> savePdf(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    File pdfExist = File('${directory.path}/invoice.pdf');
    if (await pdfExist.exists()) {
      await pdfExist.delete();
    }
    final file = await File('${directory.path}/invoice.pdf').create();
    await file.writeAsBytes(data, flush: true);
    final filePath = '${directory.path}/invoice.pdf';
    return filePath;
  }

  share() async {
    // screenshotController
    //     .captureFromLongWidget(
    //         Container(
    //             color: AppColors.white,
    //             padding: const EdgeInsets.only(left: 10, right: 10),
    //             child: const ViewReceiptToPrint(
    //               isClickLink: false,
    //             )),
    //         delay: const Duration(milliseconds: 300))
    //     .then((image) async {
    //   final tempDir = await getTemporaryDirectory();
    //   final File fileCurrent = await File(
    //           '${tempDir.path}/image${DateTime.now().toIso8601String()}.jpg')
    //       .create();
    //   fileCurrent.writeAsBytesSync(image);
    //   Share.shareFiles([fileCurrent.path]);
    // }).catchError((onError) {
    //   throw onError;
    // });
    if (invoiceId == -1) {
      showErrorAlert('Có lỗi xảy ra.', () {
        Get.back();
      });
      return;
    }
    await shareInvoice(invoiceId.toString());
  }
}
