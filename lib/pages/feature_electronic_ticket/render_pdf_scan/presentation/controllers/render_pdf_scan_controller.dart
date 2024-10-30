import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart' hide Image;
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:icorp_print_ticket/services/print_service.dart';
import 'package:icorp_print_ticket/services/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';


import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/local_storage/local_storage.dart';
import '../../../../../routes/app_pages.dart';
import '../../../detail_ticket/presentation/controllers/detail_ticket_controller.dart';
import '../../domain/adapter/render_pdf_adapter.dart';

class RenderPdfScanController extends GetxController with ControllerMixin {
  RxBool isPrinting = false.obs;

  // numbers of printing repeat
  int amountPrinting = 1;

  // FOR: PROCESS DATA
  bool canStartPrint = false;
  RxString pdfFilePath = ''.obs;
  IRenderPdfRepository repository;
  List<ModelIdArg> listId = [];
  List<ModelIdArg> listIdCurrent = [];

  RenderPdfScanController(this.repository);

  final pdfController = PdfController(
      document: PdfDocument.openAsset('assets/init_document.pdf'));

  @override
  void onInit() {
    super.onInit();
    final _ids = Get.arguments["listId"];
    final amount = Get.arguments["amountPrinting"];

    amountPrinting = amount;
    listId.addAll(_ids);
    listIdCurrent.addAll(_ids);
    getAndSavePdf();
  }

  bool processBackAndroid() {
    return !isPrinting.value;
  }

  Future<void> back() async {
    if (isPrinting.value) {
      return;
    }
    Get.back();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  Future<void> getAndSavePdf() async {
    if (listId.isEmpty) {
      isPrinting.value = false;
      return;
    }
    final item = listId[0];
    if (item.id == null) {
      return;
    }
    try {
      pdfFilePath.value = '';
      final response = await repository.getPdfView(item.id!);
      savePdf(response as Uint8List);
    } on ServerError catch (se) {
      Get.snackbar(
        "Lỗi",
        se.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    } on ApiError catch (ex) {
      Get.snackbar(
        "Lỗi",
        ex.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    }
  }

  Future<void> savePdf(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    File pdfExist = File('${directory.path}/ticket.pdf');
    if (await pdfExist.exists()) {
      await pdfExist.delete();
    }
    final file = await File('${directory.path}/ticket.pdf').create();
    await file.writeAsBytes(data, flush: true);
    final filePath = '${directory.path}/ticket.pdf';
    pdfController.loadDocument(PdfDocument.openFile(filePath));
    pdfFilePath.value = filePath;
  }

  Future<List<PdfPageImage>> getPdfImages() async {
    if (pdfFilePath.value.isNotEmpty) {
      final document = await PdfDocument.openFile(pdfFilePath.value);
      final storage = LocalStorage();
      double width = 372.0;
      if (storage.paperSize.val == 80) {
        width = 558.0;
      }
      List<PdfPageImage> datas = [];
      for (var i = 1; i <= document.pagesCount; i++) {
        final page = await document.getPage(i);
        final pageImage = await page.render(
            width: width, height: page.height * width / page.width);
        if (pageImage != null) {
          datas.add(pageImage);
        }
        await page.close();
      }
      return datas;
    }
    return [];
  }

  Future<void> processPrinting() async {
    final item = listId[0];
    final response = await repository.getPdf(item.id!, null);
    if (!canStartPrint || listId.isEmpty) {
      return;
    }
    final storage = LocalStorage();
    final condition = await PrintService.shared
        .checkPrintCondition(storage.printerMacAddress.val.isNotEmpty);
    switch (condition) {
      case PrintCondition.printNow:
        _print();
        break;
      case PrintCondition.noPrinter:
        navigateToPrintingConfig();
        break;
      case PrintCondition.bluetoothOff:
        showErrorAlert('Bật bluetooth để in.', () {
          Get.back();
        });
        break;
    }
  }

  Future<void> _print() async {
    isPrinting.value = true;
    final pdfImages = await getPdfImages();
    if (pdfImages.isEmpty) {
      isPrinting.value = false;
      showErrorAlert('Có lỗi xảy ra. Không thể in đươc. Vui lòng thử lại.', () {
        Get.back();
      });
      return;
    }
    final storage = LocalStorage();
    List<Uint8List> listData = [];
    for (var image in pdfImages) {
      listData.add(image.bytes);
    }
    final result = await PrintService.shared.printImages(
        listData,
        storage.paperSize.val == 80 ? 576 : 384,
        storage.printerName.val,
        storage.printerMacAddress.val);
    if (result == PrintingState.disconnect) {
      Get.snackbar(
        "Lỗi",
        'Có lỗi kết nối tới máy in.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
      return;
    }

    if (result == PrintingState.nodata) {
      Get.snackbar(
        "Lỗi",
        'Có lỗi dữ liệu in.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
    }

    listId.removeAt(0);

    if (PrintService.shared.isInnerPrinter) {
      Future.delayed(const Duration(seconds: 1), () {
        if (listId.isEmpty) {
          amountPrinting--;
          isPrinting.value = false;
          if (amountPrinting < 1) {
            back();
          } else {
            listId.addAll(listIdCurrent);
            getAndSavePdf();
          }
        } else {
          getAndSavePdf();
        }
      });
    } else {
      if (listId.isEmpty) {
        amountPrinting--;
        isPrinting.value = false;
        if (amountPrinting < 1) {
          Future.delayed(const Duration(seconds: 2), () {
            back();
          });
        } else {
          listId.addAll(listIdCurrent);
          getAndSavePdf();
        }
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          getAndSavePdf();
        });
      }
    }
  }

  void navigateToPrintingConfig() {
    if (isPrinting.value) {
      return;
    }
    if (GetPlatform.isAndroid) {
      Get.toNamed(Routes.printingConfig);
    } else {
      Get.toNamed(Routes.printingConfigIOS);
    }
  }
}
