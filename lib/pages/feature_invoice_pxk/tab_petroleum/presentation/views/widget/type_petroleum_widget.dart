import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/common/utils/utils.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/components/style_textfield.dart';
import '../../../../../feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';
import '../../../domain/enties/type_petroleum_entity.dart';

class TypePetroleumWidget extends GetView<TabPetroleumController> {
  const TypePetroleumWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: StyleLabel(
              title: "Loại nhiên liệu",
              titleFontSize: 16.sp,
              titleFontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Obx(() => StyleDropdownButton(
                  textStyleItemSelected: const TextStyle(color: AppColors.blue),
                  backgroundColor: AppColors.white,
                  items: controller.listTicket.map((element) {
                    if (element == controller.invoiceTemplate.value) {
                      return DropdownMenuItem<SerialEntity>(
                        value: element,
                        child: StyleLabel(
                          titleColor: AppColors.blue,
                          title: element.symbol!,
                          titleFontSize: 16.sp,
                          titleFontWeight: FontWeight.w400,
                        ),
                      );
                    }
                    return DropdownMenuItem<SerialEntity>(
                      value: element,
                      child: StyleLabel(
                        titleColor: AppColors.secondary,
                        title: element.symbol!,
                        titleFontSize: 16.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    controller.invoiceTemplate.value = v;
                  },
                  value: controller.invoiceTemplate.value,
                  onSave: (v) {
                    controller.invoiceTemplate.value = v;
                  },
                  hintText: "Ký hiệu hoá đơn",
                )),
          )
        ],
      ),
      SizedBox(height: 14.h),
      Obx(() => SizedBox(
            height: controller.listTypePetroleum.length <= 6 ? null : 250.h,
            child: GridView.count(
                shrinkWrap: true,
                primary: false,
                // padding: const EdgeInsets.all(20),
                crossAxisSpacing: 14.h,
                childAspectRatio: 181 / 68,
                mainAxisSpacing: 14.w,
                crossAxisCount: 2,
                children: [
                  for (int index = 0;
                      index < controller.listTypePetroleum.length;
                      index++)
                    ItemTypePetroleumWidget(
                      model: controller.listTypePetroleum[index],
                      index: index,
                      onTap: () {
                        if (controller.isDSLogBom.value) return;
                        controller.indexSelectTypePetroleum.value = index;
                        controller.onSelectProduct();
                      },
                    )
                ]),
          )),
    ]);
  }
}

class ItemTypePetroleumWidget extends GetView<TabPetroleumController> {
  final TypePetroleumEntity model;
  final int index;
  final Function onTap;

  const ItemTypePetroleumWidget({
    Key? key,
    required this.model,
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
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5,
                  color: index == controller.indexSelectTypePetroleum.value
                      ? AppColors.blue
                      : AppColors.secondary),
              borderRadius: BorderRadius.circular(7.sp),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              StyleLabel(
                title: model.name.toUpperCase(),
                titleFontSize: 16.sp,
                titleColor: index == controller.indexSelectTypePetroleum.value
                    ? AppColors.blue
                    : AppColors.secondary,
                titleFontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 5.h,
              ),
              StyleLabel(
                titleFontWeight: FontWeight.w500,
                title:
                    "${NumberFormat("#,###.#########").format(double.parse((model.price * 1.1).toStringAsFixed(controller.systemFormatNumber.value.unitPrice)))} VND/Lít",
                titleFontSize: 15.sp,
                titleColor: index == controller.indexSelectTypePetroleum.value
                    ? AppColors.blue
                    : AppColors.secondary2,
              ),
            ]),
          )),
    );
  }
}
