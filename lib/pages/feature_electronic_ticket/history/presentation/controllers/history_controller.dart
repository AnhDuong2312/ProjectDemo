import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';

import 'package:intl/intl.dart';

import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/components/popup_menu_custom.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../../detail_ticket/presentation/controllers/detail_ticket_controller.dart';
import '../../../list_type_ticket/domain/adapter/series_adapter.dart';
import '../../domain/adapter/history_adapter.dart';
import '../../domain/entity/history_entity.dart';

class HistoryController extends GetxController with ControllerMixin {
  final IHistoryRepository repository;
  final ISeriesRepository seriesRepository;

  HistoryController(this.repository, this.seriesRepository);

  List<dynamic> tickets = [];
  var itemSelectAllTicket = SerialEntity(id: 0, symbol: "Tất cả");
  var listHistory = <HistoryEntity>[].obs;
  var listTicket = <SerialEntity>[].obs;
  var startDateController = TextEditingController();
  var startDateForm = "";
  var endDateForm = "";
  var endDateController = TextEditingController();
  var licenceTemplateController = TextEditingController();
  var page = 1;
  var isLoadMore = true;
  var invoiceTemplate = SerialEntity(id: 0, symbol: "Tất cả").obs;

  var itemMenu = [
    ItemCustomDropDownIcon(
      id: 0,
      title: "Đăng xuất",
      icon: const Icon(Icons.login_outlined),
    ),
  ];
  var isInit = true.obs;
  var total = 0.0.obs;
  var count = 0.obs;

  @override
  Future<void> onInit() async {
    listTicket.value = [itemSelectAllTicket];
    invoiceTemplate.value = listTicket[0];
    startDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    await getSeriesInit();
    await getHistory().then((value) {
      isInit.value = false;
    });
    super.onInit();
  }

  selectMenu(int id) {
    if (id == 0) {
      logout();
    }
  }

  Future<void> getHistory() async {
    page = 1;
    isLoadMore = true;
    try {
      var param = {
        "startDate": startDateForm,
        "endDate": endDateForm,
        "limit": "10",
        "noCar": licenceTemplateController.text,
        "invoiceTemplateId":
            invoiceTemplate.value.id != 0 ? '${invoiceTemplate.value.id}' : "",
        "page": page.toString()
      };

      final response = await repository.getHistory(param);
      count.value = response["count"] ?? 0;
      total.value = response["sumTotalPrice"] ?? 0;
      listHistory.value = response["data"];
      if (response["data"].length < 10) {
        isLoadMore = false;
      }
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
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

  Future<void> getHistoryLoadMore() async {
    if (isLoadMore == false) return;
    page++;
    try {
      var param = {
        "startDate": startDateForm,
        "endDate": endDateForm,
        "limit": "10",
        "noCar": licenceTemplateController.text,
        "invoiceTemplateId":
            invoiceTemplate.value.id != 0 ? '${invoiceTemplate.value.id}' : "",
        "page": page.toString()
      };

      final response = await repository.getHistory(param);
      count.value = response["count"] ?? 0;
      total.value = response["sumTotalPrice"] ?? 0;
      if (response["data"].length < 10) {
        isLoadMore = false;
      }
      listHistory.value = listHistory.value + response["data"];

      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  Future<void> getSeriesInit() async {
    try {
      var param = {"invoiceType": "TICKET", "limit": "100", "page": "1"};
      final response = await seriesRepository.getSeries(param);

      listTicket.value = [itemSelectAllTicket] + response;
      invoiceTemplate.value = listTicket[0];
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
    } on ApiError catch (ex) {
      hideLoading();
    }
  }

  void goToDetailTicket(SerialEntity itemTicketModel, int index) {
    // tim index cua model
    Get.toNamed(Routes.ticketDetail, arguments: {
      "model": itemTicketModel,
    });
  }

  clearForm() {
    startDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateForm = DateFormat('yyyy-MM-dd').format(DateTime.now());
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    endDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    licenceTemplateController.text = "";
    invoiceTemplate.value = listTicket[0];
  }

  agreeLogout() {
    AuthService.shared.logout();
    Get.offNamed(Routes.login);
  }

  logout() {
    showErrorAlertAgree("Bạn có đồng ý đăng xuất không?", () {}, () {
      agreeLogout();
    });
  }
}
