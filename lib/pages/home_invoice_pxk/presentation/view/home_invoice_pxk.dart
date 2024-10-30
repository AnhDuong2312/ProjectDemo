import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/tab_bar_custom.dart';
import 'package:icorp_print_ticket/common/images/icons.dart';
import '../../../../../common/colors/colors.dart';
import '../../../../../common/utils/utils.dart';
import '../controller/home_invoice_pxk_controller.dart';

class HomeInvoicePxk extends StatelessWidget {
  const HomeInvoicePxk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeInvoicePxkView();
    // return WillPopScope(
    //     onWillPop: () => Utils.handleWillPop(context),
    //     child: const HomeInvoicePxkView());
  }
}

class HomeInvoicePxkView extends GetView<HomeInvoicePxkController> {
  const HomeInvoicePxkView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = (Get.width - 1.w * 3) / 3;
    final List<TabBarItem> items = [
      TabBarItem(
          itemWidth, SvgPicture.asset(AppIcons.iconTabPetroleum), "Xăng dầu",
          height: 61.h),
      TabBarItem(itemWidth, SvgPicture.asset(AppIcons.iconTabLogPetroleum),
          "DS Log Bơm",
          height: 61.h),
      TabBarItem(
          itemWidth, SvgPicture.asset(AppIcons.iconTabInvoice), "Hóa đơn",
          height: 61.h),
    ];

    return Builder(
      builder: (context) => Obx(
        () => Container(
          color: AppColors.white,
          child: Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                child: Container(
                  color: Colors.white,
                  width: Get.width,
                  height: Get.height - 60.h,
                  child: SafeArea(
                    child: IndexedStack(
                      index: controller.currentIndex.value,
                      children: controller.tabs,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: TabBarCustomView(
                    tabItems: items,
                    currentIndex: controller.currentIndex.value,
                    onTap: (index) {
                      controller.selectTab(index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
