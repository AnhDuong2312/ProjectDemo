import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:intl/intl.dart';

import '../../../../../common/colors/colors.dart';
import '../../../../../common/components/style_label.dart';
import '../../../../../common/mixins/controller_mixin.dart';
import '../../../../feature_electronic_ticket/list_type_ticket/domain/entity/serial_entity.dart';
import '../../../tab_dslog/domain/entity/invoice_state_entity.dart';
import '../../../tab_petroleum/domain/enties/type_petroleum_entity.dart';
import '../controllers/petroleum_invoice_controller.dart';

class PetroleumInvoiceSearch extends GetView<PetroleumInvoiceController>
    with ControllerMixin {
  const PetroleumInvoiceSearch({Key? key}) : super(key: key);

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
              () => controller.listSerial.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listSerial
                          .map((element) => DropdownMenuItem<SerialEntity>(
                                value: element,
                                child: StyleLabel(
                                  maxLines: 2,
                                  title: element.symbol!,
                                  titleFontSize: 14.sp,
                                  titleFontWeight: FontWeight.w400,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) {
                        controller.selectedSerial.value = v;
                      },
                      value: controller.selectedSerial.value,
                      onSave: (v) {
                        controller.selectedSerial.value = v;
                      },
                      hintText: "Ký hiệu hoá đơn",
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
          height: 10.h,
        ),
        Row(
          children: [
            Expanded(
                child: Obx(
              () => controller.listInvoiceType.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listInvoiceType
                          .map((element) => DropdownMenuItem<InvoiceTypeEntity>(
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
                        controller.selectedInvoiceType.value = v;
                      },
                      value: controller.selectedInvoiceType.value,
                      onSave: (v) {
                        controller.selectedInvoiceType.value = v;
                      },
                      hintText: "Tất cả",
                    )
                  : const SizedBox(),
            )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Obx(
              () => controller.listGoodType.isNotEmpty
                  ? StyleDropdownButton(
                      items: controller.listGoodType
                          .map((element) =>
                              DropdownMenuItem<TypePetroleumEntity>(
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
                        controller.selectedGoodType.value = v;
                      },
                      value: controller.selectedGoodType.value,
                      onSave: (v) {
                        controller.selectedGoodType.value = v;
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
            controller.fetchInvoices();
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
