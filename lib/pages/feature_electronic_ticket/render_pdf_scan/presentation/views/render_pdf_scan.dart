import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';
import 'package:pdfx/pdfx.dart';
import '../../../../../common/images/images.dart';
import '../controllers/render_pdf_scan_controller.dart';

class RenderPdfScan extends GetView<RenderPdfScanController> {
  const RenderPdfScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: const Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: RenderPdfScanView(),
            )),
        onWillPop: () async {
          return controller.processBackAndroid();
        });
  }
}

class RenderPdfScanView extends GetView<RenderPdfScanController> {
  const RenderPdfScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        controller.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, right: 20.w),
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
                  // const SizedBox()
                  IconButton(
                      onPressed: () {
                        controller.navigateToPrintingConfig();
                      },
                      icon: Image.asset(AppImages.printer)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: (Get.width - 48.h) * 462.h / 380.h,
                  child: Stack(
                    children: [
                      PdfView(
                        controller: controller.pdfController,
                        onDocumentLoaded: (document) {
                          controller.canStartPrint = true;
                        },
                        builders: PdfViewBuilders<DefaultBuilderOptions>(
                          options: const DefaultBuilderOptions(),
                          errorBuilder: (p0, error) {
                            return const StyleLabel(
                                title:
                                    'Đã có lỗi xảy ra( phần cứng không thể load pdf).');
                          },
                          documentLoaderBuilder: (_) =>
                              const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      AppColors.primary)),
                          pageLoaderBuilder: (_) => Container(
                            color: AppColors.third,
                            child: const Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        AppColors.primary))),
                          ),
                        ),
                      ),
                      Obx((() => controller.pdfFilePath.value.isEmpty
                          ? Container(
                              width: Get.width - 48.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.third,
                              ),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          AppColors.primary))),
                            )
                          : const SizedBox())),
                    ],
                  )),
              SizedBox(
                height: 35.h,
              ),
              Center(
                child: Obx(() => StyleButton(
                      onPressed: () {
                        if (!controller.isPrinting.value) {
                          controller.processPrinting();
                        }
                      },
                      title: controller.isPrinting.value ? 'ĐANG IN' : 'IN',
                      titleFontSize: 14.sp,
                      backgroundColor: controller.isPrinting.value
                          ? AppColors.secondary
                          : controller.listId.isEmpty
                              ? AppColors.secondary
                              : AppColors.primary,
                      borderRadius: 6,
                      height: 48.h,
                      width: Get.width - 48.h,
                      elevation: 4,
                    )),
              ),
            ]),
          ),
        ),
        const Spacer(),
        Column(
          children: [
            StyleLabel(
              title: 'CÔNG TY CỔ PHẦN ICORP',
              titleFontSize: 13.sp,
              titleFontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Column(
          children: [
            StyleLabel(
              title: 'https://icorp.vn - Hỗ trợ khách hàng: 1900 0099',
              titleFontSize: 14.sp,
              titleFontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
