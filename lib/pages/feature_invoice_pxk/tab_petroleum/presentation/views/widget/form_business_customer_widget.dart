import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/colors/colors.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/controllers/tab_petroleum_controller.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/presentation/views/widget/title_textfield_widget.dart';

class FormBusinessCustomer extends GetView<TabPetroleumController> {
  const FormBusinessCustomer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextFieldWidget(
          title: "Mã số thuế",
          body: Row(
            children: [
              Expanded(
                child: StyleTextField(
                  hintText: 'Nhập mã số thuế',
                  controller: controller.taxCodeController,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              InkWell(
                onTap: () {
                  controller.onSearchTax();
                },
                child: Container(
                  padding: EdgeInsets.all(13.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: AppColors.blue,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        TitleTextFieldWidget(
          title: "Tên công ty",
          body: StyleTextField(
            hintText: 'Nhập tên công ty',
            controller: controller.nameCompanyController,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        TitleTextFieldWidget(
          title: "Địa chỉ",
          body: StyleTextField(
            hintText: 'Nhập địa chỉ',
            controller: controller.addressController,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        TitleTextFieldWidget(
          title: "Người mua",
          body: StyleTextField(
            hintText: 'Nhập tên người mua',
            controller: controller.namePersonController,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        TitleTextFieldWidget(
          title: "Email",
          body: Row(
            children: [
              Expanded(
                child: StyleTextField(
                  hintText: 'Nhập email',
                  controller: controller.emailController,
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              InkWell(
                onTap: () {
                  controller.viewDraftTicket();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: AppColors.blue,
                  ),
                  child: const Icon(
                    Icons.remove_red_eye,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
