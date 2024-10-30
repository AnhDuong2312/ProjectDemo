import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/mixins/controller_mixin.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/components/components.dart';
import '../../../../../common/components/style_label.dart';
import '../../../../home_invoice_pxk/presentation/controller/home_invoice_pxk_controller.dart';
import '../../../tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';
import '../../domain/entity/ds_log_entity.dart';
import '../controllers/ds_log_controller.dart';

class DSLogList extends GetView<DSLogController> {
  const DSLogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await controller.fetchLogs();
      },
      child: Obx(() => ListView.builder(
            key: const Key("dslog_list"),
            itemBuilder: (BuildContext context, int index) {
              if (index == controller.listLog.length) {
                return VisibilityDetector(
                  key: const Key("visible_log_loadmore"),
                  onVisibilityChanged: (inf) {
                    if (inf.visibleFraction > 0.2) {
                      controller.loadMoreLogs();
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
                aspectRatio: (381 / 236),
                child: DSLogItem(
                  onTap: () {},
                  model: controller.listLog[index],
                ),
              ).paddingOnly(bottom: 16.h, right: 1.w);
            },
            itemCount: controller.listLog.length + 1,
          )),
    );
  }
}

class DSLogItem extends StatelessWidget {
  final DSLogEntity? model;
  final Function onTap;

  const DSLogItem({Key? key, required this.model, required this.onTap})
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
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Loại nhiên liệu",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        maxLines: 2,
                        title: model!.petroleumType!,
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
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Đơn giá",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        maxLines: 1,
                        title: NumberFormat("#,###").format(model!.price!),
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
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Số lít",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: NumberFormat('###.0#').format(model!.amount!),
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
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Tổng tiền",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: NumberFormat("#,###").format(model!.totalPrice!),
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
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Thời gian",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: model!.timeCreated!,
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
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Cột bơm",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: model!.nozzle!,
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                (model!.isMarked ?? false)
                    ? const Row(
                        children: [Icon(Icons.lock), SizedBox()],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: StyleLabel(
                              titleColor: AppColors.blue,
                              maxLines: 1,
                              title: model!.statusTitle(),
                              titleFontSize: 14.sp,
                              titleFontWeight: FontWeight.w400,
                            ),
                          ),
                          model!.canCreateInvoice()
                              ? StyleButton(
                                  onPressed: () {
                                    if (model!.id == null) {
                                      ControllerMixin()
                                          .showErrorAlert("id là bắt buộc", () {
                                        Get.back();
                                      });
                                      return;
                                    }
                                    Get.find<HomeInvoicePxkController>()
                                        .selectTab(0);

                                    Get.find<TabPetroleumController>()
                                        .autofillWithDataLog(model!);
                                  },
                                  height: 32.h,
                                  borderRadius: 4.sp,
                                  borderWidth: 1.sp,
                                  borderColor: AppColors.blue,
                                  title: "Tạo hóa đơn",
                                  titleColor: AppColors.blue,
                                  titleFontSize: 14.sp,
                                )
                              : const SizedBox(),
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
