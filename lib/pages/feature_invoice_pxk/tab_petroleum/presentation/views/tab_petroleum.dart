import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:pdfx/pdfx.dart';
import '../../../../../common/images/images.dart';
import '../controllers/tab_petroleum_controller.dart';
import 'widget/body_tab_petroleumn.dart';

class TabPetroleum extends GetView<TabPetroleumController> {
  const TabPetroleum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: TabPetroleumView(),
        ));
  }
}

class TabPetroleumView extends GetView<TabPetroleumController> {
  const TabPetroleumView({Key? key}) : super(key: key);

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
                      padding:
                          EdgeInsets.only(top: 10.h, bottom: 10.h, right: 20.w),
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
          const Expanded(child: BodyTabPetroleum()),
          // SizedBox(
          //   height: 10.h,
          // ),
        ],
      ),
    );
  }
}
