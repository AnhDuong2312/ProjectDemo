import 'package:get/get.dart';
import '../data/login_provider.dart';
import '../data/login_repository.dart';
import '../domain/adapter/login_adapter.dart';
import '../presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILoginProvider>(() => LoginProvider());
    Get.lazyPut<ILoginRepository>(() => LoginRepository(provider: Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
