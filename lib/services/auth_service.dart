import 'package:get/get.dart';

import '../common/local_storage/local_storage.dart';

class AuthService extends GetxService {
  static AuthService get shared => Get.find();

  final isLoggedIn = false.obs;

  bool get isLoggedInValue => isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    final LocalStorage storage = LocalStorage();
    isLoggedIn.value = storage.accessToken.val.isNotEmpty;
  }

  void logout() {
    isLoggedIn.value = false;
    final LocalStorage storage = LocalStorage();
    storage.accessToken.val = '';
    storage.userCode.val = '';
    storage.userLogin.val = '';
    storage.userPassword.val = '';
    storage.fullName.val = '';
    storage.taxCode.val = '';
    storage.userAddress.val = '';
  }

  void logoutToken() {
    isLoggedIn.value = false;
    final LocalStorage storage = LocalStorage();
    storage.accessToken.val = '';
  }

  String get accessToken => LocalStorage().accessToken.val;
}
