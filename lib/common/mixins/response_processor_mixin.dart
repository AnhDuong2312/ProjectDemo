import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:icorp_print_ticket/routes/app_pages.dart';
import 'package:icorp_print_ticket/services/auth_service.dart';
import '../api_error/api_error.dart';

class ResponseProcessorMixin {
  dynamic process(Response response) {
    if (response.statusCode == 200) {
      final status = response.body['code'];
      if (status == "00") {
        return response.body;
      } else if (status == "77") {
        String? message = response.body['message'];
        message ??= 'Rất tiếc. Đã có lỗi xảy ra.';
        AuthService.shared.logoutToken();
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
        Get.offNamed(Routes.login);
        return;
      } else {
        String? message = response.body['message'];
        message ??= 'Rất tiếc. Đã có lỗi xảy ra.';
        throw ServerError(message);
      }
    } else {
      throw ApiError('Rất tiếc. Đã có lỗi xảy ra.');
    }
  }
}
