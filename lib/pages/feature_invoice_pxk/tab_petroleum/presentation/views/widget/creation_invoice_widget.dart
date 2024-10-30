import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/tab_petroleum_enum.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';

class CreationInvoiceWidget extends GetView<TabPetroleumController> {
  const CreationInvoiceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: StyleButton(
          borderRadius: 6.sp,
          backgroundColor: AppColors.blue,
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.createAndHsmInvoiceSign();
          },
          height: 48.h,
          title: "PHÁT HÀNH",
          titleFontWeight: FontWeight.w600,
          titleFontSize: 14.sp,
          elevation: 5,
        )),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
            child: StyleButton(
          borderRadius: 6.sp,
          backgroundColor: AppColors.primary,
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.createAndHsmInvoiceSignAndPrinter();
          },
          height: 48.h,
          title: "PHÁT HÀNH\nVÀ IN HĐ",
          titleFontWeight: FontWeight.w600,
          titleFontSize: 14.sp,
          elevation: 5,
        )),
        SizedBox(
          width: 0.5.sp,
        ),
      ],
    );
  }
}
