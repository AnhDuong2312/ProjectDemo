import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/tab_petroleum_enum.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';

import '../../../../../../common/images/images.dart';

class SelectCustomerWidget extends GetView<TabPetroleumController> {
  const SelectCustomerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => StyleButton(
              padding: const EdgeInsets.only(left: 0),
              spaceBetweenIconAndText: 8.w,
              icon: SvgPicture.asset(
                controller.typeCustomer.value == TypeCustomer.visitingCustomer
                    ? AppImages.radioActive
                    : AppImages.radioInactive,
                height: 24.sp,
                width: 24.sp,
              ),
              titleColor: AppColors.secondary,
              onPressed: () {
                controller.typeCustomer.value = TypeCustomer.visitingCustomer;
              },
              titleFontWeight: FontWeight.w600,
              titleFontSize: 14.sp,
              height: 48.h,
              title: "Khách lẻ",
            )),
        const Spacer(),
        Obx(
          () => StyleButton(
            padding: const EdgeInsets.only(right: 0),
            spaceBetweenIconAndText: 8.w,
            icon: SvgPicture.asset(
              controller.typeCustomer.value == TypeCustomer.businessCustomer
                  ? AppImages.radioActive
                  : AppImages.radioInactive,
              height: 24.sp,
              width: 24.sp,
            ),
            titleColor: AppColors.secondary,
            onPressed: () {
              controller.typeCustomer.value = TypeCustomer.businessCustomer;
            },
            height: 48.h,
            titleFontWeight: FontWeight.w600,
            titleFontSize: 14.sp,
            title: "Khách doanh nghiệp",
          ),
        ),
      ],
    );
  }
}
