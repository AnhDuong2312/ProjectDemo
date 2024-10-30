import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:icorp_print_ticket/common/utils/utils.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/information_seller_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/system_format_number_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/type_petroleum_entity.dart';
import 'package:icorp_print_ticket/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/local_storage/local_storage.dart';
import '../../../../feature_electronic_ticket/list_type_ticket/domain/adapter/series_adapter.dart';
import '../../../../feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';
import '../../../custom_invoice_preview/presentation/controllers/custom_invoice_preview_controller.dart';
import '../../../tab_dslog/domain/entity/ds_log_entity.dart';
import '../../domain/adapter/tab_petroleum_adapter.dart';
import '../../domain/enties/search_tax_entity.dart';
import '../../domain/enties/tab_petroleum_enum.dart';

class TabPetroleumController extends GetxController with ControllerMixin {
  final ITabPetroleumRepository repository;
  final ISeriesRepository seriesRepository;

  ///constructor
  TabPetroleumController(this.repository, this.seriesRepository);

  var listTypePetroleum = <TypePetroleumEntity>[].obs;
  var indexSelectTypePetroleum = 0.obs;

  var listTicket = <SerialEntity>[].obs;
  var invoiceTemplate = SerialEntity(id: 0, symbol: "Tất cả").obs;

  var isDSLogBom = false.obs;
  var nameProduction = "";
  var dataLogPetroId = -1;

  var listSelectMoney = <double>[
    20000.0,
    30000.0,
    40000.0,
    50000.0,
    60000.0,
    70000.0,
    80000.0,
    90000.0,
    100000.0
  ];
  var indexSelectMoney = 0.obs;

  var totalMoneyController = TextEditingController();
  var litController = TextEditingController();
  var licensePlateController = TextEditingController();
  var emailController = TextEditingController();
  var taxCodeController = TextEditingController();
  var nameCompanyController = TextEditingController();
  var addressController = TextEditingController();
  var namePersonController = TextEditingController();
  var typeCustomer = TypeCustomer.visitingCustomer.obs;
  var systemFormatNumber = SystemFormatNumberEntity(
          quantity: 0, unitPrice: 0, totalAmount: 0, totalCost: 0)
      .obs;
  var valueTotal = 0.0;
  var valueLit = 1.0;
  var valuePriceAfterVat = 1.0;
  var informationSeller = InformationSellerEntity(
      sellerName: "",
      sellerTaxCode: "",
      sellerFullAddress: "",
      sellerPhone: "",
      sellerEmail: "",
      sellerAccountNumber: "",
      sellerBankName: "");

  @override
  Future<void> onInit() async {
    super.onInit();
    showLoading();
    await getListTypePetroleum();
    await getSeriesInit();
    await getSystemFormatNumber();
    getInformationSeller();
    onSelectTotal();
    hideLoading();
  }

  getInformationSeller() async {
    try {
      var data = await repository.getInformationSeller();
      informationSeller = data;
      return data;
    } on Exception catch (e) {
      showErrorAlert(e.toString(), () {});
    }
  }

  calculateTotal() {
    var total = valueLit *
        listTypePetroleum[indexSelectTypePetroleum.value].price *
        1.1;
    valueTotal = total;
    final formatter = ThousandsFormatter(
        allowFraction: true,
        numberOfDecimal: systemFormatNumber.value.totalAmount);
    totalMoneyController.text = formatter.textFromFormat(
        total.toStringAsFixed(systemFormatNumber.value.totalAmount));
  }

  calculateLit() {
    var lit = valueTotal /
        listTypePetroleum[indexSelectTypePetroleum.value].price /
        1.1;
    valueLit =
        double.parse(lit.toStringAsFixed(systemFormatNumber.value.quantity));
    final formatter = ThousandsFormatter(
        allowFraction: true,
        numberOfDecimal: systemFormatNumber.value.quantity);
    litController.text = formatter
        .textFromFormat(lit.toStringAsFixed(systemFormatNumber.value.quantity));
  }

  onSelectTotal() {
    final formatter = ThousandsFormatter(
        allowFraction: true,
        numberOfDecimal: systemFormatNumber.value.totalAmount);
    totalMoneyController.text = formatter.textFromFormat(
        listSelectMoney[indexSelectMoney.value]
            .toStringAsFixed(systemFormatNumber.value.totalAmount));
    valueTotal = listSelectMoney[indexSelectMoney.value];
    calculateLit();
  }

  onSelectProduct() {
    calculateLit();
  }

  Future<Map<String, dynamic>> generateParamCreateInvoice() async {
    Map<String, dynamic> param = {};

    var customerTaxCode = taxCodeController.text.trim();

    if (customerTaxCode.isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Mã số thuế là bắt buộc");
    }
    if (customerTaxCode.length != 10 &&
        customerTaxCode.length != 14 &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Mã số thuế phải có 10 hoặc 14 ký tự");
    }
    var customerEmail = emailController.text.trim();
    if (customerEmail.isNotEmpty && !customerEmail.isEmail) {
      throw ApiError("Email không đúng định dạng");
    }

    var customerName = "";
    if (typeCustomer.value == TypeCustomer.visitingCustomer) {
      final configName = await fetchNameConfig();
      if (configName == null) {
        throw ApiError("Đã có lỗi xảy ra.");
      }
      customerName =
          configName.isEmpty ? 'Khách hàng không lấy hoá đơn' : configName;
    } else {
      customerName = namePersonController.text.trim();
    }
    var customerCompanyName = nameCompanyController.text.trim();
    var customerFullAddress = addressController.text.trim();

    if (customerCompanyName.isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Tên công ty là bắt buộc");
    }

    if (customerFullAddress.isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Tên địa chỉ là bắt buộc");
    }
    var customerPhone = "";
    var totalAfterTaxVnese = await numberToWord(double.parse(
        valueTotal.toStringAsFixed(systemFormatNumber.value.totalCost)));
    if (totalAfterTaxVnese == "") {
      throw ApiError(
          "Đọc số tiền thành chữ không thành công, xin vui lòng thử lại.");
    }
    param = {
      "invoiceTemplateName": invoiceTemplate.value.name,
      // M: template.name
      "currency": "VND",
      // M: cố định
      "exchangeRate": 1,
      // M: cố định
      "date": DateTime.now().toUtc().toString(),
      // M: lấy thoi gian hien tai
      "serial": invoiceTemplate.value.symbol,
      // M ký hiệu hoá đơn
      "type": 0,
      // co dinh
      "isTaxReduction": false,
      //O hoá đơn bán hàng có giảm thuế ko
      "sellerName": informationSeller.sellerName,
      // M: api account/me: company.companyName
      "sellerTaxCode": informationSeller.sellerTaxCode,
      // M: company.taxCode
      "sellerFullAddress": informationSeller.sellerFullAddress,
      // M
      "sellerPhone": informationSeller.sellerPhone,
      // O
      "sellerEmail": informationSeller.sellerEmail,
      // O
      "sellerAccountNumber": informationSeller.sellerAccountNumber,
      // O
      "sellerBankName": informationSeller.sellerBankName,
      // O
      "sellerFax": "",
      // O
      "sellerWebsite": "",
      // O
      "customerCompanyName": customerCompanyName,
      // M nếu có customerTaxCode: doanh nghiep: ten don vi
      "customerName": customerName,
      // O: doanh nghiep: ten nguoi mua, khachle: truyen la "Khách  lẻ"
      "customerTaxCode": customerTaxCode,
      // O: mã số thuế doanh nghiệp (10 hoac 14 ki tu)
      "customerFullAddress": customerFullAddress,
      // M nếu có customerTaxCode: địa chỉ
      "customerPhone": customerPhone,
      // O
      "customerEmail": customerEmail,
      "customerPersonalIdentificationNumber": "",
      // O
      "taxRate": "10",
      // O: mac dịnh
      "total": double.parse((valueTotal / 1.1)
          .toStringAsFixed(systemFormatNumber.value.totalCost)),
      // M: tổng tiền truoc thue
      "taxMoney": double.parse((valueTotal / 1.1 * 0.1)
          .toStringAsFixed(systemFormatNumber.value.totalCost)),
      // O tong tien thue
      "totalAfterTax": double.parse(
          valueTotal.toStringAsFixed(systemFormatNumber.value.totalCost)),
      // M: tong tien sau thue
      "discountType": 0,
      // O kiểu chiết khấu 0: Không chiết khấu, 1: Theo từng mặt hàng, 2: Theo tổng giá trị
      "discountMoney": 0,
      // O
      "discount": 0,
      // O
      "totalAfterTaxVnese": totalAfterTaxVnese,
      // M: so tien bang chu
      "paymentMethod": 1,
      // O hình thức TT 1: TM/CK, 2: Tiền mặt, 3: Chuyển khoản, 4: Đối trừ công nợ, 5: Không thu tiền,
      "noCar": licensePlateController.text,
      "invoiceProduct": [
        {
          "productId": null,
          // O
          "no": 1,
          // O STT hàng trong hđơn:
          "type": 1,
          // M tính chất hàng hoá  1:Hàng hóa, dịch vụ 2: Khuyến mại 3: Chiết khấu thương mại 4: Ghi chú/diễn giải
          "name": isDSLogBom.value
              ? nameProduction
              : listTypePetroleum[indexSelectTypePetroleum.value].name,
          // M
          "unit": "lít",
          // O: don vi
          "unitPrice": double.parse(isDSLogBom.value
              ? (valuePriceAfterVat / 1.1)
                  .toStringAsFixed(systemFormatNumber.value.unitPrice)
              : listTypePetroleum[indexSelectTypePetroleum.value]
                  .price
                  .toStringAsFixed(systemFormatNumber.value.unitPrice)),
          // O: đơn giá trước thuế: 19,5846 x 1,1 = 20,234565 => lam tron là 3 sô thập phân  = 20,235
          "unitPriceAfterTax": double.parse(isDSLogBom.value
              ? valuePriceAfterVat
                  .toStringAsFixed(systemFormatNumber.value.unitPrice)
              : (listTypePetroleum[indexSelectTypePetroleum.value].price * 1.1)
                  .toStringAsFixed(systemFormatNumber.value.unitPrice)),
          // O: đơn giá sau thuế
          "quantity": valueLit,
          // O: số lượng
          "taxRate": "10",
          // O
          "taxMoney": double.parse((valueTotal / 1.1 * 0.1)
              .toStringAsFixed(systemFormatNumber.value.totalAmount)),
          // O: tien thue
          "discount": 0,
          // O
          "discountMoney": 0,
          // O
          "taxReductionRate": 0,
          // O ̀ thuế được giảm
          "taxReduction": 0,
          //O tiền thuế được giảm
          "totalUnitPrice": double.parse((valueTotal / 1.1)
              .toStringAsFixed(systemFormatNumber.value.totalCost)),
          //M : thành tien truoc thue,
          "totalUnitPriceAfterTax": double.parse(
              valueTotal.toStringAsFixed(systemFormatNumber.value.totalCost))
          //M : thành tien sau thue
        }
      ]
    };

    return param;
  }

  createInvoice() async {
    try {
      showLoading();
      Map<String, dynamic> param = await generateParamCreateInvoice();
      var data = await repository.createInvoice(param);
      isDSLogBom.value = false;
      return data;
    } on Exception catch (e) {
      hideLoading();
      showErrorAlert(e.toString(), () {
        Get.back();
      });
      return null;
    }
  }

  generateParamCreateInvoiceDataLog() async {
    Map<String, dynamic> param = {};
    var customerTaxCode = taxCodeController.text.trim();

    if (customerTaxCode.isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Mã số thuế là bắt buộc");
    }
    if (customerTaxCode.length != 10 &&
        customerTaxCode.length != 14 &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Mã số thuế phải có 10 hoặc 14 ký tự");
    }
    var customerEmail = emailController.text.trim();
    if (customerEmail.isNotEmpty && !customerEmail.isEmail) {
      throw ApiError("Email không đúng định dạng");
    }

    var customerName = "";
    if (typeCustomer.value == TypeCustomer.visitingCustomer) {
      final configName = await fetchNameConfig();
      if (configName == null) {
        throw ApiError("Đã có lỗi xảy ra.");
      }
      customerName =
          configName.isEmpty ? 'Khách hàng không lấy hoá đơn' : configName;
    } else {
      customerName = namePersonController.text.trim();
    }
    var customerCompanyName = nameCompanyController.text.trim();
    var customerFullAddress = addressController.text.trim();

    if (customerCompanyName.isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Tên công ty là bắt buộc");
    }

    if (customerFullAddress.isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      throw ApiError("Tên địa chỉ là bắt buộc");
    }
    var customerPhone = "";
    param = {
      "noCar": licensePlateController.text,
      "taxRate": "10", // mặc định
      "invoiceTemplateId": invoiceTemplate.value.id, // mặc định
      "paymentMethod": 1, // mặc định
      "customerAccountNumber": "",
      "customerBankName": "",
      "dataLogPetroIds": [dataLogPetroId],
      "customerCompanyName": customerCompanyName,
      // M nếu có customerTaxCode: doanh nghiep: ten don vi
      "customerName": customerName,
      // O: doanh nghiep: ten nguoi mua, khachle: truyen la "Khách  lẻ"
      "customerTaxCode": customerTaxCode,
      // O: mã số thuế doanh nghiệp (10 hoac 14 ki tu)
      "customerFullAddress": customerFullAddress,
      // M nếu có customerTaxCode: địa chỉ
      "customerPhone": customerPhone,
      // O
      "customerEmail": customerEmail,
    };
    return param;
  }

  createInvoiceDataLog() async {
    try {
      showLoading();
      Map<String, dynamic> param = await generateParamCreateInvoiceDataLog();
      var data = await repository.createInvoiceDataLog(param);
      return data;
    } on Exception catch (e) {
      hideLoading();
      showErrorAlert(e.toString(), () {
        Get.back();
      });
      return null;
    }
  }

  createAndHsmInvoiceSign() async {
    dynamic createData;
    if (isDSLogBom.value) {
      createData = await createInvoiceDataLog();
    } else {
      createData = await createInvoice();
    }

    if (createData != null) {
      var data = await hsmInvoiceSign(createData["data"]["invoiceId"]);
      if (data != null) {
        showSnackBar("Ký hóa đơn thành công");
      }
      hideLoading();
    }
  }

  createAndHsmInvoiceSignAndPrinter() async {
    dynamic createData;
    if (isDSLogBom.value) {
      createData = await createInvoiceDataLog();
    } else {
      createData = await createInvoice();
    }
    if (createData != null) {
      var dataHsmInvoiceSign =
          await hsmInvoiceSign(createData["data"]["invoiceId"]);

      if (dataHsmInvoiceSign != null) {
        showSnackBar("Ký hóa đơn thành công");
      }
      var nameStore = "";
      var listName =
          dataHsmInvoiceSign["data"]["invoiceOfDataLogPetroInvoice"] as List;
      if (listName.isNotEmpty) {
        nameStore = listName[0]["dataLogPetroInvoiceByDataLogPetro"]
                ["stationName"] ??
            "";
      }
      try {
        if (dataHsmInvoiceSign != null) {
          Map<String, dynamic> dataArgument = {
            "invoiceId": dataHsmInvoiceSign["data"]["invoiceId"],
            "nameStore": nameStore,
            "serial": createData["data"]["serial"] ?? "",
            "numberInvoice": dataHsmInvoiceSign["data"]["no"].toString(),
            "date": createData["data"]["date"],
            "taxAuthorityCode": createData["data"]["taxAuthorityCode"] ?? "",
            "nameProduct": (createData["data"]["invoiceProduct"] as List)[0]
                ["name"],
            "unitPrice": (createData["data"]["invoiceProduct"] as List)[0]
                    ["unitPrice"] ??
                "",
            "quantity": (createData["data"]["invoiceProduct"] as List)[0]
                    ["quantity"] ??
                "",
            "totalUnitPriceAfterTax": createData["data"]["invoiceProduct"][0]
                    ["totalUnitPriceAfterTax"] ??
                "",
            "lookupCode": dataHsmInvoiceSign["data"]["lookupCode"],
            "systemFormatNumber": systemFormatNumber.value
          };
          navigateCustomInvoicePreview(dataArgument);
          hideLoading();
        }
      } on Exception catch (e) {
        hideLoading();
        showErrorAlert(e.toString(), () {
          Get.back();
        });
      }
    }
  }

  hsmInvoiceSign(int invoiceId) async {
    try {
      Map<String, dynamic> param = {"invoiceId": invoiceId.toString()};
      var data = await repository.hsmInvoiceSign(param);
      sendEmail(
          invoiceId: invoiceId,
          customerEmail: emailController.text.trim(),
          customerName: namePersonController.text.trim());
      clearData();
      return data;
    } on Exception catch (e) {
      hideLoading();
      showErrorAlert(e.toString(), () {
        Get.back();
      });
      return null;
    }
  }

  getSystemFormatNumber() async {
    try {
      var data = await repository.getSystemFormatNumbers();
      systemFormatNumber.value = data;
    } on Exception catch (e) {
      showErrorAlert(e.toString(), () {
        Get.back();
      });
    }
  }

  sendEmail(
      {required int invoiceId,
      required String customerName,
      required String customerEmail}) async {
    try {
      if (customerEmail.isEmpty) return;
      var param = {
        "invoiceId": invoiceId,
        "customerName": customerName,
        "customerEmail": customerEmail
      };
      var data = await repository.sendEmail(param);
    } on Exception catch (e) {
      //showErrorAlert(e.toString(), () {});
    }
  }

  getListTypePetroleum() async {
    try {
      Map<String, dynamic> param = {"status": "ACTIVE"};
      var data = await repository.getProducts(param);
      listTypePetroleum.value = data;
    } on Exception catch (e) {
      showErrorAlert(e.toString(), () {
        Get.back();
      });
    }
  }

  Future<String?> fetchNameConfig() async {
    try {
      final LocalStorage storage = LocalStorage();
      if (storage.accountId.val != -1 && storage.companyId.val != -1) {
        Map<String, dynamic> param = {
          "accountId": storage.accountId.val.toString(),
          "companyId": storage.companyId.val.toString()
        };
        return await repository.fetchNameConfig(param);
      } else {
        return null;
      }
    } on Exception catch (e) {
      return null;
    }
  }

  Future<void> getSeriesInit() async {
    try {
      // var param = {"invoiceType": "TICKET", "limit": "100", "page": "1"};
      Map<String, dynamic> param = {};
      final response = await seriesRepository.getSeries(param);

      listTicket.value = response;
      invoiceTemplate.value = listTicket[0];
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  navigateCustomInvoicePreview(Map<String, dynamic> data) {
    Get.toNamed(Routes.customInvoicePreview,
        arguments: {CustomInvoicePreviewController.argumentData: data});
  }

  clearData() {
    indexSelectTypePetroleum.value = 0;
    valueTotal = 0;
    valueLit = 0;
    indexSelectMoney.value = -1;
    licensePlateController.text = "";
    emailController.text = "";
    taxCodeController.text = "";
    nameCompanyController.text = "";
    addressController.text = "";
    namePersonController.text = "";
    isDSLogBom.value = false;
    valuePriceAfterVat = 0;
    nameProduction = "";
    calculateLit();
    calculateTotal();
  }

  void autofillWithDataLog(DSLogEntity model) {
    licensePlateController.text = "";
    emailController.text = "";
    taxCodeController.text = "";
    nameCompanyController.text = "";
    addressController.text = "";
    namePersonController.text = "";

    isDSLogBom.value = true;
    dataLogPetroId = model.id!;
    var quantity_ = model.amount;
    var unitPriceAfterTax = model.price;
    var totalAmountAfterTax = model.totalPrice;
    valuePriceAfterVat = unitPriceAfterTax!;
    valueTotal = totalAmountAfterTax!;
    var quantity = "0";
    var count = Utils.getCountNumberDigitDecimal(quantity_!);

    ///-<<< Khi xuất từ log bơm nếu số thập phân của hệ thống nhiều hơn trên log thì tính lại số lít để làm tròn: log: 1.234, hệ thống là 4: 30000/23,825 = 1,2346
    final quantityFormatter = ThousandsFormatter(
        allowFraction: true,
        numberOfDecimal: systemFormatNumber.value.quantity);
    if (systemFormatNumber.value.quantity > count) {
      quantity = (valueTotal / unitPriceAfterTax)
          .toStringAsFixed(systemFormatNumber.value.quantity);
      valueLit = double.parse(quantity);
      litController.text = quantityFormatter.textFromFormat(quantity);
    } else {
      valueLit = quantity_;
      quantity = quantity_.toString();
      litController.text = quantityFormatter.textFromFormat(quantity);
    }

    ///->>>

    final formatter = ThousandsFormatter(
        allowFraction: true,
        numberOfDecimal: systemFormatNumber.value.totalAmount);
    totalMoneyController.text =
        formatter.textFromFormat(totalAmountAfterTax.toString());
    nameProduction = model.petroleumType ?? "";

    // reset highlight
    resetMoneyHightlight();
    indexSelectTypePetroleum.value = -1;
  }

  void resetMoneyHightlight() {
    if (!listSelectMoney.contains(valueTotal)) {
      indexSelectMoney.value = -1;
    } else {
      indexSelectMoney.value = listSelectMoney.indexOf(valueTotal);
    }
  }

  viewDraftTicket() async {
    try {
      showLoading();
      Map<String, dynamic> param = await generateParamCreateInvoice();
      var data = await repository.viewDraftTicket(param);
      final filePath = await savePdf(data as Uint8List);
      navigateToInvoiceView(filePath);
      hideLoading();

      return data;
    } on Exception catch (e) {
      hideLoading();
      showErrorAlert(e.toString(), () {
        Get.back();
      });
      return null;
    }
  }

  onSearchTax() async {
    var data = await searchTax();
    if (data != null) {
      nameCompanyController.text = data.nameCompany;
      namePersonController.text = '';
      addressController.text = data.address;
      emailController.text = data.email;
    }
    hideLoading();
  }

  Future<SearchTaxEntity?> searchTax() async {
    if (taxCodeController.text.trim().isEmpty &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      showErrorAlert("Mã số thuế bị trống", () {
        Get.back();
      });
      return null;
    }
    if (taxCodeController.text.trim().length != 10 &&
        taxCodeController.text.trim().length != 14 &&
        typeCustomer.value == TypeCustomer.businessCustomer) {
      showErrorAlert("Mã số thuế phải có 10 hoặc 14 ký tự", () {
        Get.back();
      });
      return null;
    }
    try {
      showLoading();
      Map<String, dynamic> param = {"taxCode": taxCodeController.text.trim()};
      var data = await repository.searchTax(param);
      return data;
    } on Exception catch (e) {
      hideLoading();
      showErrorAlert(e.toString(), () {
        Get.back();
      });
      return null;
    }
  }

  void navigateToInvoiceView(String filePath) {
    Get.toNamed(Routes.pdfPreview, arguments: {
      "file_path": filePath,
    });

    return;
  }

  Future<String> savePdf(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    File pdfExist = File('${directory.path}/draft.pdf');
    if (await pdfExist.exists()) {
      await pdfExist.delete();
    }
    final file = await File('${directory.path}/draft.pdf').create();
    await file.writeAsBytes(data, flush: true);
    final filePath = '${directory.path}/draft.pdf';
    return filePath;
  }

  Future<String?> numberToWord(num number) async {
    try {
      Map<String, dynamic> param = {
        "number": number.toString().replaceAll(".", ",")
      };
      var data = await repository.numberToWord(param);
      return data;
    } on Exception catch (e) {
      return "";
    }
  }
}
