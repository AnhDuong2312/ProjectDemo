import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:intl/intl.dart';

import '../../../../../common/colors/colors.dart';
import '../../../list_type_ticket/domain/entity/serial_entity.dart';
import '../controllers/history_controller.dart';

class FormSearchHistory extends GetView<HistoryController>
    with ControllerMixin {
  const FormSearchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000, 8),
                    lastDate: DateTime(2101));
                if (picked != null) {
                  controller.startDateController.text =
                      DateFormat('dd/MM/yyyy').format(picked);
                  controller.startDateForm =
                      DateFormat('yyyy-MM-dd').format(picked);
                  //controller.getHistory();
                }
              },
              child: StyleTextField(
                height: 40,
                fillColor: const Color(0x208E8E8E),
                controller: controller.startDateController,
                enabled: false,
                hintText: 'Từ ngày',
                iconSuffix: const Icon(Icons.date_range),
              ),
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000, 8),
                    lastDate: DateTime(2101));
                if (picked != null) {
                  controller.endDateController.text =
                      DateFormat('dd/MM/yyyy').format(picked);
                  controller.endDateForm =
                      DateFormat('yyyy-MM-dd').format(picked);
                  //controller.getHistory();
                }
              },
              child: StyleTextField(
                height: 40,
                fillColor: const Color(0x208E8E8E),
                enabled: false,
                hintText: 'Đến ngày',
                controller: controller.endDateController,
                iconSuffix: const Icon(Icons.date_range),
              ),
            )),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
                child: Obx(
              () => controller.listTicket.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listTicket
                          .map((element) => DropdownMenuItem<SerialEntity>(
                                value: element,
                                child: StyleLabel(
                                  title: element.symbol!,
                                  titleFontSize: 16.sp,
                                  titleFontWeight: FontWeight.w400,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) {
                        controller.invoiceTemplate.value = v;
                      },
                      value: controller.invoiceTemplate.value,
                      onSave: (v) {
                        controller.invoiceTemplate.value = v;
                      },
                      hintText: "Loại vé",
                    )
                  : const SizedBox(),
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: StyleTextField(
              controller: controller.licenceTemplateController,
              height: 40,
              hintText: "Nhập biển số",
            ))
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        StyleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            showLoading();
            controller.getHistory();
          },
          height: 40,
          elevation: 6.sp,
          borderRadius: 6.sp,
          backgroundColor: AppColors.primary,
          title: "TÌM KIẾM",
        )
      ],
    );
  }
}
