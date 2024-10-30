import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/images/images.dart';

import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/components/popup_menu_custom.dart';
import '../../../../../common/components/style_label.dart';
import '../../domain/entity/history_entity.dart';
import '../controllers/history_controller.dart';
import 'form_search.dart';

class History extends GetView<HistoryController> {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: const HistoryView().paddingOnly(
                left: 23.5.w, right: 23.5.w, bottom: 10.h, top: 10.h)));
  }
}

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);

  void showAlert(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    sumTotal() {
      var total = 0.0;
      for (var element in controller.listHistory) {
        total += element.totalPrice!;
      }
      return total;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          Image.asset(
            AppImages.logo,
            width: Get.width / 2,
            height: Get.width / 2 * 51 / 230,
          ),
          Row(children: [
            CustomDropdownIcon(
              body: SvgPicture.asset(
                AppImages.menu,
                color: AppColors.white,
                height: 32.sp,
                width: 32.sp,
              ),
              items: controller.itemMenu,
              onSelected: (value) {
                controller.selectMenu(value);
              },
            )
          ])
        ],
      ),
      SizedBox(
        height: 25.h,
      ),
      const FormSearchHistory(),
      SizedBox(
        height: 27.h,
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
                  title: controller.count.value.toString(),
                  titleFontSize: 16.sp,
                  titleFontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 12.h,
      ),
      Expanded(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            controller.clearForm();
            await controller.getHistory();
          },
          child: Obx(() => ListView.builder(
                key: const Key("history"),
                itemBuilder: (BuildContext context, int index) {
                  if (index == controller.listHistory.length) {
                    return VisibilityDetector(
                      key: const Key("visible_item_history"),
                      onVisibilityChanged: (inf) {
                        if (inf.visibleFraction > 0.2) {
                          controller.getHistoryLoadMore();
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
                    aspectRatio: (381 / 180),
                    child: ItemTicket(
                      onTap: () {
                        controller.navigateToPrintTicket(
                            controller.listHistory[index].id!, false);
                      },
                      model: controller.listHistory[index],
                    ),
                  ).paddingOnly(bottom: 16.h, right: 1.w);
                },
                itemCount: controller.listHistory.length + 1,
              )),
        ),
      ),
    ]);
  }
}

class ItemTicket extends StatelessWidget {
  final HistoryEntity? model;
  final Function onTap;

  const ItemTicket({Key? key, required this.model, required this.onTap})
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
                        title: "Loại vé:",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        maxLines: 2,
                        title: model!.typeTicket!,
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w700,
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
                        title: "Biển số:",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        maxLines: 1,
                        title: model!.licenceTemplate!,
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w700,
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
                        title: "Thời gian tạo vé:",
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
                        titleFontWeight: FontWeight.w700,
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
                        title: "Người tạo:",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: model!.namePersonCreate ?? "",
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
                  children: [
                    Expanded(
                      flex: 3,
                      child: StyleLabel(
                        maxLines: 1,
                        title: "Số lần in:",
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StyleLabel(
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        title: model!.noPrint.toString(),
                        titleFontSize: 14.sp,
                        titleFontWeight: FontWeight.w700,
                      ),
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
