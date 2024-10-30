import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/images/images.dart';
import 'package:icorp_print_ticket/pages/home/presentation/views/widget/item_production_service_home.dart';

import '../../../../common/colors/colors.dart';
import '../../../../common/components/popup_menu_custom.dart';
import '../../../../common/utils/utils.dart';
import '../controllers/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
          onWillPop: () => Utils.handleWillPop(context),
          child: const SafeArea(child: HomeView())),
    );
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: Get.width *  3/ 5,
                    height: Get.width * 3 / 5 * 70 / 330,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 18.h, right: 25.w),
                child: CustomDropdownIcon(
                  body: SvgPicture.asset(
                    AppImages.menu,
                    color: AppColors.secondary,
                    height: 32.sp,
                    width: 32.sp,
                  ),
                  items: controller.itemMenu,
                  onSelected: (value) {
                    controller.selectMenu(value);
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            childAspectRatio: 174 / 133,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.w,
            crossAxisCount: 2,
            children: controller.listProductionServiceHome
                .map((e) => ItemProductionServiceHome(
                      onTap: () {
                        controller.selectItem(e);
                      },
                      model: e,
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
