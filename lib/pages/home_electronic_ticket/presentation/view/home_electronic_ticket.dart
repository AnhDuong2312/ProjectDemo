import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/tab_bar_custom.dart';
import '../../../../../common/colors/colors.dart';
import '../../../../../common/utils/utils.dart';
import '../../../../common/mixins/controller_mixin.dart';
import '../controller/home_electronic_ticket_controller.dart';

class HomeElectronicTicket extends StatelessWidget with ControllerMixin {
  const HomeElectronicTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeElectronicTicketView();
  }
}

class HomeElectronicTicketView extends GetView<HomeElectronicTicketController> {
  const HomeElectronicTicketView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = (Get.width - 1.w * 2) / 2;
    final List<TabBarItem> items = [
      TabBarItem(
          itemWidth,
          const Icon(
            Icons.dashboard,
            size: 20,
          ),
          "Danh sách",
          height: 61.h),
      TabBarItem(
          itemWidth, const Icon(Icons.access_time_filled, size: 20), "Lịch sử",
          height: 61.h),
    ];

    return Builder(
      builder: (context) => Obx(
        () => Container(
          color: AppColors.primary,
          child: Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                child: Container(
                  color: Colors.white,
                  width: Get.width,
                  height: Get.height - 45,
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
