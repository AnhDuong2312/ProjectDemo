import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../colors/colors.dart';
import '../components/style_button.dart';
import '../components/style_label.dart';

class ProgressMixin {
  void showLoading() {
    if (!EasyLoading.isShow) {
      EasyLoading.show(status: null, maskType: EasyLoadingMaskType.custom);
    }
  }

  void hideLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}

class AlertMixin {
  void showErrorAlert(String message, VoidCallback onClose) {
    Get.defaultDialog(
        title: '',
        radius: 15,
        content: SizedBox(
          width: Get.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleLabel(
                maxLines: 1000,
                title: message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              StyleButton(
                  title: 'Đóng',
                  width: 150,
                  height: 50,
                  borderRadius: 25,
                  backgroundColor: AppColors.primary,
                  onPressed: onClose)
            ],
          ),
        ));
  }
}

class ControllerMixin {
  void showLoading() {
    if (!EasyLoading.isShow) {
      EasyLoading.show(status: null, maskType: EasyLoadingMaskType.custom);
    }
  }

  void hideLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  void showSnackBar(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      dismissDirection: DismissDirection.up,
      backgroundColor: AppColors.blue,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      duration: const Duration(seconds: 2),
    ));
  }

  Future<bool> showBackWillScope(
      String message, VoidCallback onClose, Function agree) async {
    var isCloseApp = false;
    await Get.defaultDialog(
        title: '',
        radius: 15,
        content: SizedBox(
          width: Get.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleLabel(
                title: message.tr,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleButton(
                      title: "Không",
                      width: (Get.width - 100) / 2 - 20,
                      height: 50,
                      borderRadius: 25,
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        onClose();
                        isCloseApp = false;
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  StyleButton(
                      title: "Có",
                      width: (Get.width - 100) / 2 - 20,
                      height: 50,
                      borderRadius: 25,
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        Get.back();
                        isCloseApp = true;
                      })
                ],
              ),
            ],
          ),
        ));
    return isCloseApp;
  }

  void showErrorAlert(String message, VoidCallback onClose) {
    Get.defaultDialog(
        title: '',
        radius: 15,
        content: SizedBox(
          width: Get.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleLabel(
                maxLines: 1000,
                title: message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              StyleButton(
                  title: 'Đóng',
                  width: 150,
                  height: 50,
                  borderRadius: 25,
                  backgroundColor: AppColors.primary,
                  onPressed: onClose)
            ],
          ),
        ));
  }

  void showErrorAlertAgree(
      String message, VoidCallback onClose, Function agree) {
    Get.defaultDialog(
        title: '',
        radius: 15,
        content: SizedBox(
          width: Get.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleLabel(
                title: message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleButton(
                      title: "không",
                      width: (Get.width - 100) / 2 - 20,
                      height: 50,
                      borderRadius: 25,
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        Get.back();
                        onClose();
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  StyleButton(
                      title: 'có',
                      width: (Get.width - 100) / 2 - 20,
                      height: 50,
                      borderRadius: 25,
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        Get.back();
                        agree();
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
