import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/components/style_textfield.dart';
import '../../../../../feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';
import '../../../domain/enties/type_petroleum_entity.dart';

class SelectMoneyPetroleumWidget extends GetView<TabPetroleumController> {
  const SelectMoneyPetroleumWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          StyleLabel(
            title: "Chọn số tiền",
            titleFontSize: 16.sp,
            titleFontWeight: FontWeight.w500,
          ),
        ],
      ),
      SizedBox(height: 14.h),
      GridView.count(
          shrinkWrap: true,
          primary: false,
          // padding: const EdgeInsets.all(20),
          crossAxisSpacing: 14.h,
          childAspectRatio: 181 / 64,
          mainAxisSpacing: 14.w,
          crossAxisCount: 3,
          children: [
            for (int index = 0;
                index < controller.listSelectMoney.length;
                index++)
              ItemTypePetroleumWidget(
                cost: controller.listSelectMoney[index],
                index: index,
                onTap: () {
                  if (controller.isDSLogBom.value) return;
                  controller.indexSelectMoney.value = index;
                  controller.onSelectTotal();
                },
              )
          ]),
    ]);
  }
}

class ItemTypePetroleumWidget extends GetView<TabPetroleumController> {
  final double cost;
  final int index;
  final Function onTap;

  const ItemTypePetroleumWidget({
    Key? key,
    required this.cost,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Obx(() => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5,
                  color: index == controller.indexSelectMoney.value
                      ? AppColors.blue
                      : AppColors.secondary),
              borderRadius: BorderRadius.circular(100.sp),
            ),
            child: StyleLabel(
              title: NumberFormat("#,###.#######").format(double.parse(cost.toStringAsFixed(0))),
              titleFontSize: 16.sp,
              titleColor: index == controller.indexSelectMoney.value
                  ? AppColors.blue
                  : AppColors.secondary,
              titleFontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
