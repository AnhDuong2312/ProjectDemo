import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';

import '../../../../../common/api_error/api_error.dart';
import '../../../../../common/components/popup_menu_custom.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../domain/adapter/series_adapter.dart';


class ListTypeTicketController extends GetxController with ControllerMixin {
  final ISeriesRepository repository;

  ListTypeTicketController(this.repository);

  var listTicket = <SerialEntity>[].obs;
  List<dynamic> tickets = [];
  var page = 1;
  var isLoadMore = true;
  var isInit = true.obs;

  var itemMenu = [
    ItemCustomDropDownIcon(
      id: 0,
      title: "Đăng xuất",
      icon: const Icon(Icons.login_outlined),
    ),
  ];

  @override
  Future<void> onInit() async {
    await getSeries().then((value) {
      isInit.value = false;
    });

    super.onInit();
  }

  selectMenu(int id) {
    if (id == 0) {
      logout();
    }
  }

  Future<void> getSeries() async {
    page = 1;
    isLoadMore = true;
    try {
      var param = {
        "invoiceType": "TICKET",
        "limit": "10",
        "page": page.toString()
      };
      final response = await repository.getSeries(param);

      listTicket.value = response;
      if (response.length < 10) {
        isLoadMore = false;
      }
      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
      showErrorAlert(
        se.message,
        () {
          Get.back();
        },
      );
    } on ApiError catch (ex) {
      hideLoading();
      showErrorAlert(
        ex.message,
        () {
          Get.back();
        },
      );
    }
  }

  Future<void> getSeriesLoadMore() async {
    if (isLoadMore == false) return;
    page++;
    try {
      var param = {
        "invoiceType": "TICKET",
        "limit": "10",
        "page": page.toString()
      };
      final response = await repository.getSeries(param);

      if (response.length < 10) {
        isLoadMore = false;
      }
      listTicket.value = listTicket.value + response;

      hideLoading();
    } on ServerError catch (se) {
      hideLoading();
      showErrorAlert(
        se.message,
        () {
          Get.back();
        },
      );
    } on ApiError catch (ex) {
      hideLoading();
      showErrorAlert(
        ex.message,
        () {
          Get.back();
        },
      );
    }
  }

  void goToDetailTicket(SerialEntity itemTicketModel, int index) {
    // tim index cua model
    Get.toNamed(Routes.ticketDetail, arguments: {
      "model": itemTicketModel,
    });
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
