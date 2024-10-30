import 'package:get/get.dart';

import '../data/tab_petroleum_provider.dart';
import '../data/tab_petroleum_repository.dart';
import '../domain/adapter/tab_petroleum_adapter.dart';
import '../presentation/controllers/tab_petroleum_controller.dart';

class TabPetroleumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabPetroleumController(Get.find(), Get.find()));
    Get.lazyPut<ITabPetroleumProvider>(() => TabPetroleumProvider());
    Get.lazyPut<ITabPetroleumRepository>(
        () => TabPetroleumRepository(provider: Get.find()));
  }
}
