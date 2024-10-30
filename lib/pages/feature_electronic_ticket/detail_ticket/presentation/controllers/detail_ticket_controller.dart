import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/colors/colors.dart';
import '../../../../../common/local_storage/local_storage.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/print_service.dart';
import '../../../../../services/printing.dart';
import '../../../list_type_ticket/domain/entity/serial_entity.dart';
import '../../../render_pdf_scan/domain/adapter/render_pdf_adapter.dart';
import '../../domain/adapter/serial_adapter.dart';

class ModelIdArg {
  String? id;

  ModelIdArg(this.id);
}

class DetailTicketController extends GetxController with ControllerMixin {
  ISerialRepository repository;
  IRenderPdfRepository pdfRepository;
  List<ModelIdArg> listId = [];
  var focusPrintCmd = FocusNode();
  var detailModel = SerialEntity().obs;

  DetailTicketController(this.repository, this.pdfRepository);

  var priceController = TextEditingController();
  var typeTicketController = TextEditingController();
  var licenceTemplateController = TextEditingController();

  @override
  void onInit() {
    detailModel.value = Get.arguments["model"];

    priceController.text =
        NumberFormat("#,###", "en_vn").format(detailModel.value.price);
    typeTicketController.text = detailModel.value.name!;

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();

    focusPrintCmd.dispose();
  }

  void back() {
    if (isPrinting) {
      return;
    }
    Get.back();
  }

  Map<String, dynamic> generateParamCreatedTicket() {
    final LocalStorage storage = LocalStorage();
    return {
      "name": "ticket",
      "ticketDraftItems": [
        {
          "nameTicket": detailModel.value.name,
          "sellerTaxCode": storage.taxCode.val,
          "sellerName": storage.fullName.val,
          "sellerFullAddress": storage.userAddress.val.isEmpty
              ? 'VietInvoice'
              : storage.userAddress.val,
          "invoiceTemplateId": detailModel.value.id,
          "serial": detailModel.value.symbol,
          "quantity": 1,
          "price": (detailModel.value.price! /
                  (100 + detailModel.value.rateTax!) *
                  100)
              .round(),
          "taxRate": detailModel.value.rateTax,
          "taxMoney": (detailModel.value.price! /
                  (100 + detailModel.value.rateTax!) *
                  100 *
                  detailModel.value.rateTax! /
                  100)
              .round(),
          "totalPrice": detailModel.value.price!,
          "dateCreate": DateTime.now().toString(),
          "departureDateTime": DateTime.now().toString(),
          "nameRoute": "",
          "routeStart": "",
          "routeEnd": "",
          "noSeatCar": "",
          "noCar": licenceTemplateController.text,
          "namePersonCreate": LocalStorage().fullName.val,
          "totalPriceVnese": "",
          "serialDevice": PrintService.shared.sunmiSerial
        }
      ]
    };
  }

  saveAndPrintTicket() async {
    if (isPrinting) {
      return;
    }
    final canPrint = await _checkPrint();
    if (!canPrint) {
      return;
    }
    showLoading();
    var param = generateParamCreatedTicket();

    try {
      var response = await repository.createTicketDraft(param);
      await _print(
              response["data"]["ticketDraftId"],
              response["data"]["ticketDraftItems"][0]["ticketDraftItemId"]
                  .toString())
          .then((value) {
        hideLoading();
      });
    } on ServerError catch (se) {
      hideLoading();
      showErrorAlert(se.message, () {
        Get.back();
      });
    } on ApiError catch (ex) {
      hideLoading();
      showErrorAlert(ex.message, () {
        Get.back();
      });
    }
  }

  releaseAndPrintTicket() async {
    if (isPrinting) {
      return;
    }
    final canPrint = await _checkPrint();
    if (!canPrint) {
      return;
    }
    showLoading();
    var paramCreate = generateParamCreatedTicket();
    print(paramCreate);
    var listId = [];
    try {
      var response = await repository.createTicketDraft(paramCreate);
      listId = [response["data"]["ticketDraftId"]];
      var param = {
        "ticketDraftId": listId,
        "waitTaxRes": true,
        "waitTaxResTimeout": "2000"
      };
      var responseRelease = await repository.releaseTicket(param);
      final result = responseRelease['result'];
      if (result == 'success') {
        await _print(
                responseRelease["successSignTickets"][0]["createdTicketId"]
                    .toString(),
                null)
            .then((value) {
          hideLoading();
        });
      } else {
        hideLoading();
        showErrorAlert('Ký vé bị lỗi.', () {
          Get.back();
        });
      }
    } on ServerError catch (se) {
      hideLoading();
      showErrorAlert(se.message, () {
        Get.back();
      });
    } on ApiError catch (ex) {
      hideLoading();
      showErrorAlert(ex.message, () {
        Get.back();
      });
    }
  }

  void navigateToPrintTicket(int id, bool isDraftTicket) {
    Get.toNamed(Routes.printTicket, arguments: {
      "listId": [ModelIdArg(id.toString())],
      "amountPrinting": 1,
      "isDraftTicket": isDraftTicket
    });

    return;
  }

  // ------------- PRINTING------------------
  bool isPrinting = false;

  Future<bool> _checkPrint() async {
    final storage = LocalStorage();
    final condition = await PrintService.shared
        .checkPrintCondition(storage.printerMacAddress.val.isNotEmpty);
    switch (condition) {
      case PrintCondition.printNow:
        return true;
      case PrintCondition.noPrinter:
        navigateToPrintingConfig();
        return false;
      case PrintCondition.bluetoothOff:
        showErrorAlert('Bật bluetooth để in.', () {
          Get.back();
        });
        return false;
    }
  }

  void navigateToPrintingConfig() {
    if (GetPlatform.isAndroid) {
      Get.toNamed(Routes.printingConfig);
    } else {
      Get.toNamed(Routes.printingConfigIOS);
    }
  }

  Future<void> _print(String? ticketId, String? ticketDraftItemId) async {
    isPrinting = true;
    final pdfData = await _getData(ticketId, ticketDraftItemId);
    if (pdfData == null) {
      isPrinting = false;
      return;
    } else {
      final pdfFilePath = await _savePdf(pdfData);
      final pdfImages = await getPdfImages(pdfFilePath);
      if (pdfImages.isEmpty) {
        isPrinting = false;
        showErrorAlert('Có lỗi xảy ra. Không thể in đươc. Vui lòng thử lại.',
            () {
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
      switch (result) {
        case PrintingState.success:
          Future.delayed(const Duration(seconds: 1), () {
            isPrinting = false;
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
          isPrinting = false;
          break;
        case PrintingState.nodata:
          Get.snackbar(
            "Lỗi",
            'Có lỗi dữ liệu in.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.primary,
            colorText: Colors.white,
          );
          isPrinting = false;
          break;
      }
    }
  }

  Future<Uint8List?> _getData(
      String? ticketId, String? ticketDraftItemId) async {
    try {
      final response = await pdfRepository.getPdf(ticketId, ticketDraftItemId);
      return response as Uint8List;
    } on ServerError catch (se) {
      Get.snackbar(
        "Lỗi",
        se.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
      return null;
    } on ApiError catch (ex) {
      Get.snackbar(
        "Lỗi",
        ex.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
      );
      return null;
    }
  }

  Future<String> _savePdf(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    File pdfExist = File('${directory.path}/ticket.pdf');
    if (await pdfExist.exists()) {
      await pdfExist.delete();
    }
    final file = await File('${directory.path}/ticket.pdf').create();
    await file.writeAsBytes(data, flush: true);
    final filePath = '${directory.path}/ticket.pdf';
    return filePath;
  }

  Future<List<PdfPageImage>> getPdfImages(String pdfFilePath) async {
    if (pdfFilePath.isNotEmpty) {
      try {
        final document = await PdfDocument.openFile(pdfFilePath);
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
      } on Exception catch (_) {
        return [];
      }
    }
    return [];
  }

//-----------------------------------------
}
