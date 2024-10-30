import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/colors/colors.dart';
import '../../../../../common/components/components.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../feature_electronic_ticket/list_type_ticket/domain/adapter/series_adapter.dart';
import '../../../../feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';
import '../../../tab_dslog/domain/entity/invoice_state_entity.dart';
import '../../../tab_petroleum/domain/enties/type_petroleum_entity.dart';
import '../../data/petroleum_invoice_repository.dart';
import '../../domain/entity/petroleum_invoice_entity.dart';

class PetroleumInvoiceController extends GetxController with ControllerMixin {
  final IPetroleumInvoiceRepository repository;
  final ISeriesRepository seriesRepository;
  var startDateForm = "";
  var startDateController = TextEditingController();
  var endDateForm = "";
  var endDateController = TextEditingController();

  // load more
  var isLoadMore = false;

  var listInvoice = <PetroleumInvoiceEntity>[].obs;
  var total = 0.0.obs;
  var invoiceAmount = 0.obs;
  var page = 1;

  //  Ký hiệu hoá đơn
  var listSerial = <SerialEntity>[].obs;
  var selectedSerial = SerialEntity(id: 0, symbol: "Tất cả ký hiệu").obs;

  // Trạng thái hoá đơn
  var listInvoiceState = <InvoiceStateEntity>[].obs;
  var selectedInvoiceState =
      InvoiceStateEntity(code: 'ALL_INVOICE', name: 'Tất cả hoá đơn').obs;

  //  Loại hoá đơn
  var listInvoiceType = <InvoiceTypeEntity>[].obs;
  var selectedInvoiceType =
      InvoiceTypeEntity(code: 'ALL_TYPE', name: 'Tất cả loại HĐ').obs;

  //  Loại hàng hoá
  var listGoodType = <TypePetroleumEntity>[].obs;
  var selectedGoodType = TypePetroleumEntity(
          code: 'ALL_TYPE',
          name: 'Tất cả hàng hoá',
          id: -1,
          price: -1.0,
          unitName: '',
          vat: 10.0)
      .obs;

  PetroleumInvoiceController(this.repository, this.seriesRepository);

  var emailController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    startDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    listSerial.value = [SerialEntity(id: 0, symbol: "Tất cả ký hiệu")];
    selectedSerial.value = listSerial[0];

    listInvoiceState.value = [
      InvoiceStateEntity(code: 'ALL_INVOICE', name: 'Tất cả hoá đơn'),
      InvoiceStateEntity(code: 'AUTHORITY_CODE_GIVEN', name: 'Đã cấp mã'),
      InvoiceStateEntity(
          code: 'AUTHORITY_CODE_NOT_GIVEN', name: 'Từ chối cấp mã'),
      InvoiceStateEntity(code: 'NOT_SENT_TO_AUTHORITY', name: 'Chưa phát hành'),
      InvoiceStateEntity(code: 'SENDING_TAX', name: 'Đang gửi CQT'),
      InvoiceStateEntity(code: 'WAITING_FOR_AUTHORITY', name: 'Chờ CQT xử lý'),
      InvoiceStateEntity(code: 'AUTHORITY_ACCEPT', name: 'CQT xác nhận hợp lệ'),
      InvoiceStateEntity(code: 'AUTHORITY_DENY', name: 'CQT từ chối'),
      InvoiceStateEntity(code: 'SEND_ERROR', name: 'Gửi lỗi'),
      InvoiceStateEntity(code: 'SIGN_ERROR', name: 'Ký lỗi')
    ];
    selectedInvoiceState.value = listInvoiceState[0];

    listInvoiceType.value = [
      InvoiceTypeEntity(code: 'ALL_TYPE', name: 'Tất cả loại HĐ'),
      InvoiceTypeEntity(code: 'HD', name: 'HĐ GTGT'),
      InvoiceTypeEntity(code: 'MTT', name: 'HĐ MTT'),
    ];
    selectedInvoiceType.value = listInvoiceType[0];

    listGoodType.value = [
      TypePetroleumEntity(
          code: 'ALL_TYPE',
          name: 'Tất cả hàng hoá',
          id: -1,
          price: -1.0,
          unitName: '',
          vat: 10.0),
    ];
    selectedGoodType.value = listGoodType[0];

    await fetchSerials();
    await fetchGoodTypes();
    await fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    page = 1;
    isLoadMore = true;
    showLoading();
    try {
      var param = {
        "startDate": startDateForm,
        "endDate": endDateForm,
        "limit": "10",
        "issueStatus": selectedInvoiceState.value.code != 'ALL_INVOICE'
            ? selectedInvoiceState.value.code
            : null,
        "serials":
            selectedSerial.value.id != 0 ? selectedSerial.value.symbol : null,
        "page": page.toString(),
        "classify": selectedInvoiceType.value.code != 'ALL_TYPE'
            ? selectedInvoiceType.value.code
            : null,
        "good": selectedGoodType.value.code != 'ALL_TYPE'
            ? selectedGoodType.value.code
            : null
      };

      final response = await repository.fetchPetroleumInvoices(param);
      invoiceAmount.value = response.invoiceAmount ?? 0;
      total.value = response.total ?? 0;
      listInvoice.value = response.invoices;
      if (response.invoices.length < 10) {
        isLoadMore = false;
      }
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  Future<void> loadMoreInvoices() async {
    if (isLoadMore == false) return;
    page++;
    try {
      var param = {
        "startDate": startDateForm,
        "endDate": endDateForm,
        "limit": "10",
        "issueStatus": selectedInvoiceState.value.code != 'ALL_INVOICE'
            ? selectedInvoiceState.value.code
            : null,
        "serials":
            selectedSerial.value.id != 0 ? selectedSerial.value.symbol : null,
        "page": page.toString(),
        "classify": selectedInvoiceType.value.code != 'ALL_TYPE'
            ? selectedInvoiceType.value.code
            : null,
        "good": selectedGoodType.value.code != 'ALL_TYPE'
            ? selectedGoodType.value.code
            : null
      };

      final response = await repository.fetchPetroleumInvoices(param);
      invoiceAmount.value = response.invoiceAmount ?? 0;
      total.value = response.total ?? 0;
      listInvoice.value = listInvoice.value + response.invoices;
      if (response.invoices.length < 10) {
        isLoadMore = false;
      }
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  Future<void> fetchSerials() async {
    try {
      Map<String, dynamic> param = {};
      final response = await seriesRepository.getSeries(param);

      listSerial.value =
          [SerialEntity(id: 0, symbol: "Tất cả ký hiệu")] + response;
      selectedSerial.value = listSerial[0];
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  fetchGoodTypes() async {
    try {
      Map<String, dynamic> param = {"status": "ACTIVE"};
      var data = await repository.fetchGoodTypes(param);
      listGoodType.value = [
            TypePetroleumEntity(
                code: 'ALL_TYPE',
                name: 'Tất cả hàng hoá',
                id: -1,
                price: -1.0,
                unitName: '',
                vat: 10.0),
          ] +
          data;
      selectedGoodType.value = listGoodType[0];
    } on Exception catch (e) {
      showErrorAlert(e.toString(), () {
        Get.back();
      });
    }
  }

  clearForm() {
    startDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  void navigateToInvoiceView(String filePath) {
    Get.toNamed(Routes.pdfPreview, arguments: {
      "file_path": filePath,
    });

    return;
  }

  // fetch pdf
  Future<void> fetchInvoicePdf(String invoiceId) async {
    showLoading();
    try {
      final response = await repository.exportPdf(invoiceId);
      final filePath = await savePdf(response as Uint8List);
      navigateToInvoiceView(filePath);
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

  Future<void> sendEmail(int? invoiceId) async {
    Get.back();
    var customerEmail = emailController.text.trim();
    if (customerEmail.isEmpty || !customerEmail.isEmail) {
      showErrorAlert('Nhập email không đúng. Vui lòng nhập lại.', () {
        Get.back();
      });
      return;
    }
    var username = usernameController.text.trim();
    if (username.isEmpty) {
      showErrorAlert('Tên không được để trống. Vui lòng nhập lại.', () {
        Get.back();
      });
      return;
    }

    print("có thể gửi email");
    try {
      if (invoiceId == null) return;
      var param = {
        "invoiceId": invoiceId,
        "customerName": username,
        "customerEmail": customerEmail
      };
      var data = await repository.sendEmail(param);
      print('response = $data');
    } on Exception catch (e) {
      //showErrorAlert(e.toString(), () {});
    }
  }

  void showInputEmail(String? email, String? username, int? invoiceId) {
    final customerEmail = email ?? '';
    final customerName = username ?? '';
    emailController.text = customerEmail;
    usernameController.text = customerName;
    Get.defaultDialog(
        title: '',
        radius: 15,
        content: SizedBox(
          width: Get.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleTextField(
                hintText: 'Nhập Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              StyleTextField(
                hintText: 'Nhập tên',
                controller: usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              StyleButton(
                  title: 'Gửi Email',
                  width: 150,
                  height: 50,
                  borderRadius: 25,
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    sendEmail(invoiceId);
                  })
            ],
          ),
        ));
  }
}
