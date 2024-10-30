import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/domain/entity/invoice_state_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/domain/entity/nozzle_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/domain/entity/station_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/type_petroleum_entity.dart';
import 'package:intl/intl.dart';

import '../../../../../common/colors/colors.dart';
import '../../../../../common/components/style_label.dart';
import '../controllers/ds_log_controller.dart';

class DSLogSearch extends GetView<DSLogController> with ControllerMixin {
  const DSLogSearch({Key? key}) : super(key: key);

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
                }
              },
              child: StyleTextField(
                textFontSize: 14.sp,
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
                textFontSize: 14.sp,
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
              () => controller.listStation.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listStation
                          .map((element) => DropdownMenuItem<StationEntity>(
                                value: element,
                                child: StyleLabel(
                                  maxLines: 2,
                                  title: element.name!,
                                  titleFontSize: 14.sp,
                                  titleFontWeight: FontWeight.w400,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) {
                        controller.selectedStation.value = v;
                        controller.updateNozzle();
                      },
                      value: controller.selectedStation.value,
                      onSave: (v) {
                        controller.selectedStation.value = v;
                        controller.updateNozzle();
                      },
                      hintText: "Trạm xăng dầu",
                    )
                  : const SizedBox(),
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Obx(
              () => controller.listNozzle.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listNozzle
                          .map((element) => DropdownMenuItem<NozzleEntity>(
                                value: element,
                                child: StyleLabel(
                                  maxLines: 2,
                                  title: element.name!,
                                  titleFontSize: 14.sp,
                                  titleFontWeight: FontWeight.w400,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) {
                        controller.selectedNozzle.value = v;
                      },
                      value: controller.selectedNozzle.value,
                      onSave: (v) {
                        controller.selectedNozzle.value = v;
                      },
                      hintText: "Cột bơm",
                    )
                  : const SizedBox(),
            ))
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
                child: Obx(
              () => controller.listPetroleumType.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listPetroleumType
                          .map((element) => DropdownMenuItem<String>(
                                value: element,
                                child: StyleLabel(
                                  maxLines: 2,
                                  title: element,
                                  titleFontSize: 14.sp,
                                  titleFontWeight: FontWeight.w400,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) {
                        controller.selectedPetroleumType.value = v;
                      },
                      value: controller.selectedPetroleumType.value,
                      onSave: (v) {
                        controller.selectedPetroleumType.value = v;
                      },
                      hintText: "Loại nhiên liệu",
                    )
                  : const SizedBox(),
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Obx(
              () => controller.listInvoiceState.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listInvoiceState
                          .map(
                              (element) => DropdownMenuItem<InvoiceStateEntity>(
                                    value: element,
                                    child: StyleLabel(
                                      maxLines: 2,
                                      title: element.name,
                                      titleFontSize: 14.sp,
                                      titleFontWeight: FontWeight.w400,
                                    ),
                                  ))
                          .toList(),
                      onChanged: (v) {
                        controller.selectedInvoiceState.value = v;
                      },
                      value: controller.selectedInvoiceState.value,
                      onSave: (v) {
                        controller.selectedInvoiceState.value = v;
                      },
                      hintText: "",
                    )
                  : const SizedBox(),
            ))
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        StyleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            //showLoading();
            controller.fetchLogs();
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
