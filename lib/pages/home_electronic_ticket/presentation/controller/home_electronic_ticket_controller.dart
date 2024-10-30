import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_electronic_ticket/history/presentation/views/history.dart';

import '../../../feature_electronic_ticket/list_type_ticket/presentation/views/list_type_ticket.dart';


class HomeElectronicTicketController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<Widget> tabs = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabs = [
      const SafeArea(child: ListTypeTicket()),
      const SizedBox(),
    ];
  }

  void selectTab(int index) {
    if (tabs[index] is SizedBox) {
      if (index == 0) {
        tabs[index] = const SafeArea(child: ListTypeTicket());
      } else if (index == 1) {
        tabs[index] = const SafeArea(child: History());
      }
    }
    currentIndex.value = index;
  }
}
