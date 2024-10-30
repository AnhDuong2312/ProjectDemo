import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../common/colors/colors.dart';
import '../../../../common/components/style_label.dart';
import '../../../../common/images/images.dart';
import '../presentation/pdf_preview_controller.dart';

class PdfPreview extends GetView<PreviewPdfController> {
  const PdfPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: PdfFileView(),
        ));
  }
}

class PdfFileView extends GetView<PreviewPdfController> {
  const PdfFileView({Key? key}) : super(key: key);

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
                  const SizedBox()
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: (Get.width - 48.h) * 462.h / 380.h,
                  child: PdfView(
                    controller: controller.pdfController,
                    onDocumentLoaded: (document) {},
                    builders: PdfViewBuilders<DefaultBuilderOptions>(
                      options: const DefaultBuilderOptions(),
                      errorBuilder: (p0, error) {
                        return const StyleLabel(
                            title: 'Đã có lỗi xảy ra(không thể load pdf).');
                      },
                      documentLoaderBuilder: (_) =>
                          const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.primary)),
                      pageLoaderBuilder: (_) => Container(
                        color: AppColors.third,
                        child: const Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppColors.primary))),
                      ),
                    ),
                  ))
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
