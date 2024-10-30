import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/components/components.dart';
import '../../../../../common/components/style_label.dart';
import '../../domain/entity/petroleum_invoice_entity.dart';
import '../controllers/petroleum_invoice_controller.dart';

class PetroleumInvoiceList extends GetView<PetroleumInvoiceController> {
  const PetroleumInvoiceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await controller.fetchInvoices();
      },
      child: Obx(() => ListView.builder(
            key: const Key("petroleum_invoice_list"),
            itemBuilder: (BuildContext context, int index) {
              if (index == controller.listInvoice.length) {
                return VisibilityDetector(
                  key: const Key("visible_petroleum_invoice_loadmore"),
                  onVisibilityChanged: (inf) {
                    if (inf.visibleFraction > 0.2) {
                      controller.loadMoreInvoices();
                    }
                  },
                  child: Visibility(
                    visible: controller.isLoadMore,
                    child: Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 24.sp,
                            width: 24.sp,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 3.sp,
                            ))),
                  ),
                );
              }

              return AspectRatio(
                aspectRatio: (381 / 190),
                child: PetroleumInvoiceItem(
                  onTap: () {},
                  model: controller.listInvoice[index],
                ),
              ).paddingOnly(bottom: 16.h, right: 1.w);
            },
            itemCount: controller.listInvoice.length + 1,
          )),
    );
  }
}

class PetroleumInvoiceItem extends GetView<PetroleumInvoiceController> {
  final PetroleumInvoiceEntity? model;
  final Function onTap;

  const PetroleumInvoiceItem(
      {Key? key, required this.model, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5.sp, color: const Color(0xFF8B8B8B)),
          borderRadius: BorderRadius.circular(13.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                StyleLabel(
                  title: model!.companyName!,
                  maxLines: 2,
                  titleFontSize: 14.sp,
                  titleFontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "MST: ${model!.taxNumber ?? ''}",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: StyleLabel(
                        maxLines: 1,
                        title: model!.invoiceNumber ?? "",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Ký hiệu: ${model!.serial!}",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: model!.date!,
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "HĐ mới",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: NumberFormat("#,###").format(model!.totalPrice!),
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StyleButton(
                      onPressed: () {
                        controller.fetchInvoicePdf(model!.id.toString());
                      },
                      height: 32.h,
                      // width: 125.w,
                      borderRadius: 4.sp,
                      borderWidth: 1.sp,
                      borderColor: AppColors.blue,
                      title: "Xem hoá đơn",
                      titleColor: AppColors.blue,
                      titleFontSize: 14.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    StyleButton(
                      onPressed: () {
                        controller.showInputEmail(model!.customerEmail,
                            model!.customerName, model!.id);
                      },
                      height: 32.h,
                      // width: 120.w,
                      borderRadius: 4.sp,
                      borderWidth: 1.sp,
                      borderColor: AppColors.blue,
                      title: "Gửi email",
                      titleColor: AppColors.blue,
                      titleFontSize: 14.sp,
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
