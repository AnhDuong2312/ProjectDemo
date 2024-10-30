import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/images/images.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../common/components/popup_menu_custom.dart';
import '../../../../../common/components/style_label.dart';
import '../../domain/entity/serial_entity.dart';
import '../controllers/list_type_ticket_controller.dart';

class ListTypeTicket extends GetView<ListTypeTicketController> {
  const ListTypeTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: ListTypeTicketView())
        // .paddingOnly(left: 23.5.w, right: 23.5.w, bottom: 10.h, top: 10.h)
        );
  }
}

class ListTypeTicketView extends GetView<ListTypeTicketController> {
  const ListTypeTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Stack(
        children: [
          Image.asset(
            AppImages.bannerSeries,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10.h, bottom: 10.h, right: 20.w),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: AppColors.white,
                      size: 18.sp,
                    ),
                  )),
              Image.asset(
                AppImages.logo,
                width: Get.width / 2,
                height: Get.width / 2 * 51 / 230,
                color: AppColors.white,
              ),
              const Spacer(),

            ],
          ).paddingOnly(left: 23.5.w, right: 23.5.w, top: 10.h)
        ],
      ),
      Container(
        padding: EdgeInsets.only(
          top: 271.h,
        ),
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            await controller.getSeries();
          },
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.white),
            child: Column(
              children: [
                StyleLabel(
                  title: "Danh sách các loại vé",
                  titleFontWeight: FontWeight.w700,
                  titleFontSize: 20.sp,
                ).paddingOnly(top: 15.h, bottom: 15.h),
                Expanded(
                    child: Obx(() => GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                controller.listTicket.isNotEmpty ? 2 : 1,
                            childAspectRatio: (186 / 145),
                            mainAxisSpacing: 12.sp,
                            crossAxisSpacing: 12.sp,
                          ),
                          itemCount: controller.isLoadMore
                              ? controller.listTicket.length + 1
                              : controller.listTicket.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == controller.listTicket.length) {
                              return Visibility(
                                visible: controller.isLoadMore,
                                child: Center(
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      height: 24.sp,
                                      width: 24.sp,
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                        strokeWidth: 3.sp,
                                      )),
                                ),
                              );
                            }
                            if (index == controller.listTicket.length - 1) {
                              return VisibilityDetector(
                                  key: const Key("visible_item_type_ticket"),
                                  child: ItemTicket(
                                    onTap: () {
                                      controller.goToDetailTicket(
                                          controller.listTicket[index], index);
                                    },
                                    model: controller.listTicket[index],
                                  ),
                                  onVisibilityChanged: (inf) {
                                    if (inf.visibleFraction > 0.2) {
                                      controller.getSeriesLoadMore();
                                    }
                                  });
                            }
                            return ItemTicket(
                              onTap: () {
                                controller.goToDetailTicket(
                                    controller.listTicket[index], index);
                              },
                              model: controller.listTicket[index],
                            );
                          },
                        ).paddingOnly(left: 17.5.w, right: 17.5.w, top: 10.h))),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}

class ItemTicket extends StatelessWidget {
  final SerialEntity? model;
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
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundSeries),
            ),
            boxShadow: [
              // BoxShadow(
              //   offset: const Offset(0, 1),
              //   blurRadius: 2.sp,
              //   spreadRadius: 0,
              //   color: AppColors.black.withOpacity(0.25),
              // ),
            ]
            // color: const Color(0xFFE9E9E9),
            // borderRadius: BorderRadius.circular(13.sp),
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
                  maxLines: 2,
                  titleColor: AppColors.white,
                  title: model!.name!,
                  titleFontSize: 18.sp,
                  titleFontWeight: FontWeight.w600,
                ).paddingOnly(left: 12.w),
                StyleLabel(
                  maxLines: 1,
                  titleFontSize: 23.sp,
                  titleColor: AppColors.white,
                  titleFontWeight: FontWeight.w600,
                  title: "${NumberFormat("##,###").format(model!.price)}Đ ",
                ).paddingOnly(left: 12.w),
              ],
            )),
            StyleLabel(
              titleColor: AppColors.white,
              title: model!.symbol!,
              titleFontSize: 14.sp,
              titleFontWeight: FontWeight.w600,
            ).paddingOnly(left: 12.w),
            SizedBox(
              height: 22.h,
            )
          ],
        ),
      ).paddingOnly(bottom: 5.h),
    );
  }
}
