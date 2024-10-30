import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/images/icons.dart';
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:icorp_print_ticket/services/auth_service.dart';
import 'package:icorp_print_ticket/services/print_service.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../../../common/components/popup_menu_custom.dart';
import '../../../../common/local_storage/local_storage.dart';
import '../../../../routes/app_pages.dart';
import '../domain/entity/item_production_service_home_entity.dart';

class HomeController extends GetxController with ControllerMixin {
  var listProductionServiceHome = <ItemProductionServiceHomeEntity>[
    ItemProductionServiceHomeEntity(
        title: "Hóa đơn, PXK",
        type: EnumItemProductionServiceHome.invoiceAndPXK,
        icon: SvgPicture.asset(AppIcons.iconInvoicePxk)),
    ItemProductionServiceHomeEntity(
        title: "Vé điện tử",
        type: EnumItemProductionServiceHome.electronicTicket,
        icon: SvgPicture.asset(AppIcons.iconElectronicTicket)),
  ];

  selectItem(ItemProductionServiceHomeEntity model) {
    switch (model.type) {
      case EnumItemProductionServiceHome.invoiceAndPXK:
        navigateInvoicePxk();
        break;
      case EnumItemProductionServiceHome.electronicTicket:
        navigateElectronicTicket();
        break;
    }
  }

  void navigateElectronicTicket() {
    Get.toNamed(Routes.homeElectronicTicket);
  }

  void navigateInvoicePxk() {
    Get.toNamed(Routes.homeInvoicePXK);
  }

  var itemMenu = [
    ItemCustomDropDownIcon(
      id: 0,
      title: "Đăng xuất",
      icon: const Icon(Icons.login_outlined),
    ),
  ];

  logout() {
    showErrorAlertAgree("Bạn có đồng ý đăng xuất không?", () {}, () {
      agreeLogout();
    });
  }

  agreeLogout() {
    AuthService.shared.logout();
    Get.offNamed(Routes.login);
  }

  selectMenu(int id) {
    if (id == 0) {
      logout();
    }
  }
}
