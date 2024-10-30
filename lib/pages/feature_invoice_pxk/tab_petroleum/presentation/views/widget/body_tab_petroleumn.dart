import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/views/widget/select_customer_widget.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/views/widget/select_money_petroleum_widget.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/views/widget/type_petroleum_widget.dart';

import '../../../domain/enties/tab_petroleum_enum.dart';
import '../../controllers/tab_petroleum_controller.dart';
import 'creation_invoice_widget.dart';
import 'form_business_customer_widget.dart';
import 'form_general_widget.dart';

class BodyTabPetroleum extends GetView<TabPetroleumController> {
  const BodyTabPetroleum({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const TypePetroleumWidget(),
        SizedBox(
          height: 20.h,
        ),
        const SelectMoneyPetroleumWidget(),
        SizedBox(
          height: 20.h,
        ),
        const FormGeneral(),
        SizedBox(
          height: 20.h,
        ),
        const SelectCustomerWidget(),
        Obx(() => controller.typeCustomer.value == TypeCustomer.businessCustomer
            ? SizedBox(
          height: 20.h,
              )
            : const SizedBox()),
        Obx(() => controller.typeCustomer.value == TypeCustomer.businessCustomer
            ? const FormBusinessCustomer()
            : const SizedBox()),
        SizedBox(
          height: 20.h,
        ),
        const CreationInvoiceWidget(),
        SizedBox(
          height: 20.h,
        ),
        StyleLabel(
          title: 'CÔNG TY CỔ PHẦN ICORP',
          titleFontSize: 13.sp,
          titleFontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: 5.h,
        ),
        StyleLabel(
          title: 'https://icorp.vn - Hỗ trợ khách hàng: 1900 0099',
          titleFontSize: 14.sp,
          titleFontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 20.h,
        ),
      ]),
    );
  }
}
