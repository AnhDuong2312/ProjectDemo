import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/app_environment/app_environtment.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../common/colors/colors.dart';
import '../../../../../common/components/style_label.dart';
import '../../../../../common/mixins/server_config_mixin.dart';

class TicketPreview extends StatelessWidget with ServerConfigMixin {
  final String serial;
  final String invoiceNo;
  final String date;
  final String taxAuthorityCode;
  final String carNo;
  final String price;
  final String lookupCode;
  const TicketPreview(
      {Key? key,
      required this.serial,
      required this.invoiceNo,
      required this.date,
      required this.taxAuthorityCode,
      required this.carNo,
      required this.price,
      required this.lookupCode})
      : super(key: key);

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
              title: "VÉ GỬI XE",
              titleFontSize: 22.sp,
              titleFontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          StyleLabel(
            title: "Ký hiệu: $serial",
            titleFontWeight: FontWeight.w500,
            titleFontSize: 16.sp,
          ),
          SizedBox(
            height: 10.h,
          ),
          StyleLabel(
            title: "Số hóa đơn: $invoiceNo",
            titleFontWeight: FontWeight.w500,
            titleFontSize: 16.sp,
          ),
          SizedBox(
            height: 10.h,
          ),
          StyleLabel(
            title: "Ngày phát hành: $date",
            titleFontWeight: FontWeight.w500,
            titleFontSize: 16.sp,
          ),
          SizedBox(
            height: 10.h,
          ),
          StyleLabel(
            title: "Mã CQT: $taxAuthorityCode",
            titleFontWeight: FontWeight.w500,
            titleFontSize: 16.sp,
          ),
          SizedBox(
            height: 10.h,
          ),
          StyleLabel(
            title: "Biển số xe: $carNo",
            titleFontWeight: FontWeight.w700,
            titleFontSize: 16.sp,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleLabel(
                title: "Giá vé:",
                titleFontWeight: FontWeight.w500,
                titleFontSize: 16.sp,
              ),
              StyleLabel(
                title: "$price đồng",
                titleFontWeight: FontWeight.w700,
                titleFontSize: 20.sp,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Center(
              child: QrImageView(
                  data:
                      "${getEnvironment().serverURLQR}invoice/export-by-lookup-code?lookupCode=$lookupCode}",
                  size: Get.width / 2)),
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
            child: StyleLabel(
              title: "icorp.vn",
              titleFontWeight: FontWeight.w500,
              titleFontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
