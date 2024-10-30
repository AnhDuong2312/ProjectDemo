import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:intl/intl.dart';


import '../controllers/detail_ticket_controller.dart';

class FormDetailTicket extends GetView<DetailTicketController> {
  const FormDetailTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Nhập biển số xe",
          titleFontSize: 16.sp,
          titleFontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6.sp),
        Row(
          children: [
            Expanded(
                child: StyleTextField(
              hintText: "Nhập biển số xe",
              controller: controller.licenceTemplateController,
            )),
            SizedBox(
              width: 8.w,
            ),
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: InkWell(
                onTap: () async {
                  // var data = await Get.toNamed(Routes.cameraScanLicence);
                  // if (data != null) {
                  //   if (data["data"] != "") {
                  //     controller.licenceTemplateController.text =
                  //         data["data"].toString().toUpperCase();
                  //   }
                  // }
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: const Color(0xff4770B7),
                      borderRadius: BorderRadius.circular(6.sp)),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 24.sp),
        StyleLabel(
          title: "Loại vé",
          titleFontSize: 16.sp,
          titleFontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6.sp),
        StyleTextField(
          enabled: false,
          hintText: "Nhập loại vé",
          controller: controller.typeTicketController,
        ),
        SizedBox(height: 24.sp),
        StyleLabel(
          title: "Giá tiền",
          titleFontSize: 16.sp,
          titleFontWeight: FontWeight.w500,
        ),
        SizedBox(height: 6.sp),
        StyleTextField(
          enabled: false,
          hintText: "Nhập giá tiền",
          formatNumber: [NumericTextFormatter()],
          controller: controller.priceController,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 40.sp),
        Row(
          children: [
            // Expanded(
            //     child: StyleButton(
            //   onPressed: () {
            //     FocusScope.of(context).unfocus();
            //     controller.saveAndPrintTicket();
            //   },
            //   title: "LƯU VÀ IN VÉ",
            //   height: 48.h,
            //   elevation: 6.sp,
            //   backgroundColor: AppColors.primary,
            //   borderRadius: 6.sp,
            // )),
            // SizedBox(
            //   width: 10.w,
            // ),
            Expanded(
                child: StyleButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.releaseAndPrintTicket();
              },
              title: "PHÁT HÀNH VÀ IN VÉ",
              height: 48.h,
              elevation: 6.sp,
              backgroundColor: const Color(0xff4770B7),
              borderRadius: 6.sp,
            )),
          ],
        )
      ],
    );
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
