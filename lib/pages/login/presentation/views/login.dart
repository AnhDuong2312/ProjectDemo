import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/common/components/components.dart';
import 'package:icorp_print_ticket/common/components/style_label.dart';

import '../../../../common/colors/colors.dart';
import '../../../../common/images/images.dart';
import '../../../../common/utils/utils.dart';
import '../controllers/login_controller.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.handleWillPop(context),
      child: const Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: SingleChildScrollView(child: LoginView())),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: Get.height - Get.statusBarHeight / 2),
        child: Column(children: [
          SizedBox(
            height: 120.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 58.w),
            child: AspectRatio(
              aspectRatio: 313 / 70,
              child: Image.asset(
                AppImages.logo,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          const LoginInputView(),
          const Spacer(),
          Column(
            children: [
              StyleLabel(
                title: 'CÔNG TY CỔ PHẦN ICORP',
                titleFontSize: 13.sp,
                titleFontWeight: FontWeight.w600,
              ),
              // SizedBox(
              //   height: 16,
              // )
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
          )
        ]),
      ),
    );
  }
}

class LoginInputView extends GetView<LoginController> {
  const LoginInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus(controller.codeFocus);
    return Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      alignment: Alignment.centerRight,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        StyleLabel(
          title: "Mã số thuế",
          titleFontSize: 16.sp,
          titleFontWeight: FontWeight.w500,
        ).paddingOnly(bottom: 6.h),
        SizedBox(
          height: 48.h,
          child: StyleTextField(
            titleColor: AppColors.hintText,
            // focusNode: controller.codeFocus,
            // onEditingComplete: () =>
            //     controller.usernameFocus.requestFocus(controller.codeFocus),
            controller: controller.codeController,
            keyboardType:
                Platform.isAndroid ? TextInputType.number : TextInputType.text,
            textFontSize: 14.sp,
            hintText: "Nhập mã số thuế",
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        StyleLabel(
          title: "Tên đăng nhập",
          titleFontSize: 16.sp,
          titleFontWeight: FontWeight.w500,
        ).paddingOnly(bottom: 6.h),
        SizedBox(
          height: 48.h,
          child: StyleTextField(
            titleColor: AppColors.hintText,
            textFontSize: 14.sp,
            // focusNode: controller.usernameFocus,
            // onEditingComplete: () =>
            //     controller.passwordFocus.requestFocus(controller.usernameFocus),
            controller: controller.usernameController,
            hintText: "Nhập tên đăng nhập",
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        StyleLabel(
          title: "Mật khẩu",
          titleFontSize: 16.sp,
          titleFontWeight: FontWeight.w500,
        ).paddingOnly(bottom: 6.h),
        SizedBox(
          height: 48.h,
          child: SecureTextField(
            titleColor: AppColors.hintText,
            textFontSize: 14.sp,
            // focusNode: controller.passwordFocus,
            controller: controller.passwordController,
            // onEditingComplete: () {
            //   FocusScope.of(context).unfocus();
            // },
            hintText: "Nhập mật khẩu",
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: StyleLabel(
              title: "Quên mật khẩu",
              titleColor: const Color(0xFF4770B7),
              titleFontSize: 14.sp,
              titleFontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        StyleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.login();
          },
          title: 'ĐĂNG NHẬP',
          titleFontSize: 14.sp,
          backgroundColor: AppColors.primary,
          titleFontWeight: FontWeight.w600,
          borderRadius: 6,
          height: 48.h,
          width: double.infinity,
          elevation: 4.h,
        )
      ]),
    );
  }
}
