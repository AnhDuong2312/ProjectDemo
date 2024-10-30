import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/app_environment/app_environtment.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/images/images.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/components/style_button.dart';
import '../../../../../common/components/style_label.dart';
import '../../../../../common/mixins/server_config_mixin.dart';
import '../controllers/custom_invoice_preview_controller.dart';

class CustomInvoicePreview extends GetView<CustomInvoicePreviewController> {
  const CustomInvoicePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: const CustomInvoicePreviewView().paddingOnly(
                left: 23.5.w, right: 23.5.w, bottom: 10.h, top: 10.h)));
  }
}

class CustomInvoicePreviewView extends GetView<CustomInvoicePreviewController> {
  const CustomInvoicePreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                width: Get.width / 2,
                height: Get.width / 2 * 51 / 230,
              ),
            ],
          ),
          InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 20.w),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 18.sp,
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  controller.navigateToPrintingConfig();
                },
                icon: Image.asset(AppImages.printer)),
          ),
        ],
      ),
      SizedBox(
        height: 25.h,
      ),
      Expanded(
        child: Container(
            color: AppColors.white,
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Column(
              children: [
                const Expanded(
                    child: SingleChildScrollView(child: ViewReceiptToPrint(isClickLink: true,))),
                Obx(() => Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: StyleButton(
                            elevation: 5,
                            onPressed: () {
                              // controller.processPrinting();
                              controller.isPrinting.value
                                  ? () {}
                                  : controller.share();
                            },
                            title: "CHIA SẺ",
                            height: 46,
                            backgroundColor: controller.isPrinting.value
                                ? AppColors.secondary
                                : AppColors.blue,
                            borderRadius: 6,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Visibility(
                          // visible: Platform.isAndroid,
                          child: Expanded(
                            flex: 1,
                            child: StyleButton(
                              elevation: 5,
                              onPressed: () {
                                // controller.processPrinting();
                                controller.isPrinting.value
                                    ? () {}
                                    : controller.processPrinting();
                              },
                              title: "IN HÓA ĐƠN",
                              height: 46,
                              backgroundColor: controller.isPrinting.value
                                  ? AppColors.secondary
                                  : AppColors.primary,
                              borderRadius: 6,
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      )
    ]);
  }
}

class ViewReceiptToPrint extends GetView<CustomInvoicePreviewController>
    with ServerConfigMixin {
  final bool isClickLink;

  const ViewReceiptToPrint({
    Key? key,
    required this.isClickLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: StyleLabel(
              title: "HÓA ĐƠN THANH TOÁN",
              titleFontSize: 20.sp,
              titleFontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => controller.nameStore.value != ""
              ? StyleLabel(
                  title: "Cửa hàng: ${controller.nameStore.value}",
                  titleFontWeight: FontWeight.w500,
                  titleFontSize: 16.sp,
                ).paddingOnly(bottom: 10.h)
              : const SizedBox()),
          Obx(() => StyleLabel(
                title: "Ký hiệu: ${controller.serial.value}",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => StyleLabel(
                title: "Số hóa đơn: ${controller.numberInvoice.value}",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => StyleLabel(
                title: "Ngày phát hành: ${controller.date.value}",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => StyleLabel(
                title: "Mã CQT: ${controller.taxAuthorityCode.value}",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              )),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => StyleLabel(
                title: "Tên hàng hóa: ${controller.nameProduct.value}",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleLabel(
                title: "Giá bán",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              ),
              Obx(() => StyleLabel(
                    title: "${controller.unitPrice} đồng",
                    titleFontWeight: FontWeight.w700,
                    titleFontSize: 16.sp,
                  )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleLabel(
                title: "Số lượng: ",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              ),
              Obx(() => StyleLabel(
                    title: "${controller.quantity.value} lít",
                    titleFontWeight: FontWeight.w700,
                    titleFontSize: 16.sp,
                  )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleLabel(
                title: "Tổng tiền thanh toán",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              ),
              Obx(() => StyleLabel(
                    title: "${controller.totalUnitPriceAfterTax.value} đồng",
                    titleFontWeight: FontWeight.w700,
                    titleFontSize: 16.sp,
                  )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
              child: Obx(() => QrImageView(
                  data:
                      "${getEnvironment().serverURLQR}invoice/export-by-lookup-code?lookupCode=${controller.lookupCode.value}",
                  size: Get.width / 2))),
          SizedBox(
            height: 10.h,
          ),
          StyleLabel(
            title: "(Quét mã QR Code để xem hóa đơn ICORP VietInvoice)",
            maxLines: 2,
            titleFontWeight: FontWeight.w500,
            titleFontSize: 14.sp,
          ),
          Center(
            child: isClickLink
                ? InkWell(
                    onTap: () async {
                      var url = Uri.parse("https://vietinvoice.vn/");
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: StyleLabel(
                      title: "icorp.vn",
                      titleFontWeight: FontWeight.w500,
                      titleFontSize: 14.sp,
                      titleColor: AppColors.blue,
                    ),
                  )
                : StyleLabel(
                    title: "icorp.vn",
                    titleFontWeight: FontWeight.w500,
                    titleFontSize: 14.sp,
                    titleColor: AppColors.blue,
                  ),
          ),
        ],
      ),
    );
  }
}
