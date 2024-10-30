import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/presentation/views/ds_log.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_invoice/presentation/views/petroleum_invoice.dart';

import '../../../feature_invoice_pxk/tab_petroleum/presentation/views/tab_petroleum.dart';

class HomeInvoicePxkController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<Widget> tabs = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabs = [
      const SafeArea(child: TabPetroleum()),
      const SizedBox(),
      const SizedBox(),
    ];
  }

  void selectTab(int index) {
    if (tabs[index] is SizedBox) {
      if (index == 0) {
        tabs[index] = const SafeArea(child: TabPetroleum());
      } else if (index == 1) {
        tabs[index] = const SafeArea(child: DSLog());
      } else if (index == 2) {
        tabs[index] = const SafeArea(child: PetroleumInvoice());
      }
    }
    currentIndex.value = index;
  }
}
