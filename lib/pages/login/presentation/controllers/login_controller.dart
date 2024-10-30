import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/api_error/api_error.dart';
import '../../../../common/local_storage/local_storage.dart';
import '../../../../common/mixins/controller_mixin.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/auth_service.dart';
import '../../domain/adapter/login_adapter.dart';
import '../../domain/entity/login_response.dart';

class LoginController extends GetxController with ControllerMixin {
  final ILoginRepository repository;
  final codeController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final codeFocus = FocusNode();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  LoginController(this.repository);

  @override
  void onInit() {
    final LocalStorage storage = LocalStorage();
    codeController.text = storage.userCode.val;
    usernameController.text = storage.userLogin.val;
    passwordController.text = storage.userPassword.val;
    super.onInit();
  }

  @override
  void dispose() {
    codeFocus.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    codeController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validateServer() {
    if (codeController.text.trim() == "") {
      showErrorAlert("Mã số thuế không được để trống", () {
        Get.back();
      });
      return false;
    }
    // if (usernameController.text.trim() == "") {
    //   showErrorAlert("Tên đăng nhập không được để trống", () {
    //     Get.back();
    //   });
    //   return false;
    // }
    if (passwordController.text.trim() == "") {
      showErrorAlert("Mật khẩu không được để trống", () {
        Get.back();
      });
      return false;
    }

    return true;
  }

  Future<void> login() async {
    var validate = validateServer();
    if (!validate) return;
    showLoading();
    try {
      final response = await repository.login(codeController.text,
          usernameController.text, passwordController.text);
      final loginResponse = LoginResponse.fromJson(response);
      if (loginResponse.accessToken != "") {
        final LocalStorage storage = LocalStorage();
        storage.accessToken.val = loginResponse.accessToken.toString();
        if (storage.accessToken.val != "") {
          storage.isAutoLogin.val = true;
          storage.fullName.val = loginResponse.account!.fullname ?? "";
          if (loginResponse.account?.taxCode != null) {
            storage.taxCode.val = loginResponse.account!.taxCode!;
          }
          if (loginResponse.account?.address != null) {
            storage.userAddress.val = loginResponse.account!.address!;
          }
          if (loginResponse.account?.accountId != null) {
            storage.accountId.val = loginResponse.account!.accountId!;
          }
          if (loginResponse.account?.companyId != null) {
            storage.companyId.val = loginResponse.account!.companyId!;
          }
          AuthService.shared.isLoggedIn.value = true;
        }
        Get.offNamed(Routes.home);
      } else {}

      hideLoading();
    } on ServerError catch (se) {
      showErrorAlert(
        se.message,
        () {
          Get.back();
        },
      );
      hideLoading();
    } on ApiError catch (ex) {
      showErrorAlert(
        ex.message,
        () {
          Get.back();
        },
      );
      hideLoading();
    }
  }

// void showDialogError(String text) {
//   showDialog(
//     context: Get.context!,
//     builder: (context) => AlertDialog(
//       title: const Text('Lỗi'),
//       content: Text(text),
//       actions: [
//         ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Quay lại'))
//       ],
//     ),
//   );
// }
}
