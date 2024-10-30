import 'package:get/get.dart';

import '../data/history_provider.dart';
import '../data/history_repository.dart';
import '../domain/adapter/history_adapter.dart';
import '../presentation/controllers/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController(Get.find(), Get.find()));
    Get.lazyPut<IHistoryProvider>(() => HistoryProvider());
    Get.lazyPut<IHistoryRepository>(
        () => HistoryRepository(provider: Get.find()));
  }
}
