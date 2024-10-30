import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/presentation/controllers/ds_log_controller.dart';
import 'package:intl/intl.dart';

import '../../../../../common/colors/colors.dart';
import '../../../../../common/components/style_label.dart';
import '../../../../../common/images/images.dart';
import 'ds_log_list.dart';
import 'ds_log_search.dart';

class DSLog extends GetView<DSLogController> {
  const DSLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: DSLogView(),
        ));
  }
}

class DSLogView extends GetView<DSLogController> {
  const DSLogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
      child: Column(
        children: [
          Column(children: [
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
                    // const SizedBox()
                  ],
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.h, bottom: 10.h, right: 20.w),
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 18.sp,
                      ),
                    )),
              ],
            ),
          ]),
          SizedBox(
            height: 22.h,
          ),
          const DSLogSearch(),
          SizedBox(
            height: 22.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  StyleLabel(
                    title: "Tổng tiền: ",
                    titleFontSize: 14.sp,
                    titleFontWeight: FontWeight.w400,
                  ),
                  Obx(() => StyleLabel(
                        title:
                            '${NumberFormat("#,###").format(controller.total.value)} đ',
                        titleFontSize: 16.sp,
                        titleFontWeight: FontWeight.w700,
                      )),
                ],
              ),
              Row(
                children: [
                  StyleLabel(
                    title: "Số lượng: ",
                    titleFontSize: 14.sp,
                    titleFontWeight: FontWeight.w400,
                  ),
                  Obx(
                    () => StyleLabel(
                      title: controller.logAmount.value.toString(),
                      titleFontSize: 16.sp,
                      titleFontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const Expanded(child: DSLogList()),
        ],
      ),
    );
  }
}
