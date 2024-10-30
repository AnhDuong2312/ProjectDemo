import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/colors/colors.dart';
import '../../../../../common/components/style_label.dart';
import '../../../../../common/images/images.dart';
import '../../../../../services/print_service.dart';
import '../controllers/detail_ticket_controller.dart';
import 'form_detail_ticket.dart';

class DetailTicket extends GetView<DetailTicketController> {
  const DetailTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: DetailTicketView()));
  }
}

class DetailTicketView extends GetView<DetailTicketController> {
  const DetailTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: Get.height - Get.statusBarHeight / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 18.sp,
                    )),
              ),
              Image.asset(
                AppImages.logo,
                width: Get.width / 2,
                height: Get.width / 2 * 51 / 230,
              ),
              IconButton(
                  onPressed: () {
                    controller.navigateToPrintingConfig();
                  },
                  icon: Image.asset(
                    AppImages.printer,
                    width: 45,
                    height: 41,
                  )),
            ],
          ),
          PrintService.shared.sunmiSerial == null
              ? const SizedBox()
              : Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    StyleLabel(
                      titleFontWeight: FontWeight.bold,
                      titleColor: Colors.black,
                      title: 'Serial: ${PrintService.shared.sunmiSerial ?? ''}',
                    )
                  ],
                ),
          SizedBox(
            height: 26.h,
          ),
          const FormDetailTicket(),
          const Spacer(),
          Column(
            children: [
              Center(
                child: StyleLabel(
                  title: 'CÔNG TY CỔ PHẦN ICORP',
                  titleFontSize: 13.sp,
                  titleFontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Column(
            children: [
              Center(
                child: StyleLabel(
                  title: 'https://icorp.vn - Hỗ trợ khách hàng: 1900 0099',
                  titleFontSize: 14.sp,
                  titleFontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ]),
      ),
    ).paddingOnly(
      left: 23.5.w,
      right: 23.5.w,
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
