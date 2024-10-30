import 'package:get/get.dart';

import '../presentation/controllers/start_controller.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartController());
  }
}
