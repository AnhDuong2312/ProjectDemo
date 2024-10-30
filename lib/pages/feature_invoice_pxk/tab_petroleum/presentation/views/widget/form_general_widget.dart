import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/tab_petroleum_enum.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/views/widget/title_textfield_widget.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class FormGeneral extends GetView<TabPetroleumController> {
  const FormGeneral({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => TitleTextFieldWidget(
              title: "Tổng tiền",
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyleTextField(
                      hintText: 'Nhập số tiền',
                      controller: controller.totalMoneyController,
                      enabled: controller.isDSLogBom.value ? false : true,
                      onChanged: (text) {
                        final value = text.replaceAll(RegExp(','), '');
                        controller.valueTotal =
                            double.parse(value != "" ? value : "0");

                        controller.resetMoneyHightlight();
                        controller.calculateLit();
                      },
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      formatNumber: [
                        ThousandsFormatter(
                            allowFraction: true,
                            numberOfDecimal: controller
                                .systemFormatNumber.value.totalAmount),
                      ],
                    )
                  ]),
            )),
        SizedBox(
          height: 15.h,
        ),
        Obx(() => TitleTextFieldWidget(
              title: "Số lít",
              body: StyleTextField(
                hintText: 'Nhập số lít',
                controller: controller.litController,
                enabled: controller.isDSLogBom.value ? false : true,
                onChanged: (text) {
                  final value = text.replaceAll(RegExp(','), '');
                  controller.valueLit = double.parse(value != "" ? value : "0");
                  controller.calculateTotal();
                  controller.resetMoneyHightlight();
                },
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                formatNumber: [
                  ThousandsFormatter(
                      allowFraction: true,
                      numberOfDecimal:
                          controller.systemFormatNumber.value.quantity),
                ],
              ),
            )),
        SizedBox(
          height: 15.h,
        ),
        TitleTextFieldWidget(
          title: "Biển số xe",
          body: Row(
            children: [
              Expanded(
                child: StyleTextField(
                  hintText: "Nhập biển số xe",
                  controller: controller.licensePlateController,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              InkWell(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: AppColors.blue,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(() => controller.typeCustomer.value == TypeCustomer.visitingCustomer
            ? SizedBox(
                height: 15.h,
              )
            : const SizedBox()),
        Obx(() => controller.typeCustomer.value == TypeCustomer.visitingCustomer
            ? TitleTextFieldWidget(
                title: "Email",
                body: Row(
                  children: [
                    Expanded(
                      child: StyleTextField(
                        hintText: 'Nhập email',
                        controller: controller.emailController,
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    InkWell(
                      onTap: () {
                        controller.viewDraftTicket();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.w, horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          color: AppColors.blue,
                        ),
                        child: const Icon(
                          Icons.remove_red_eye,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}
