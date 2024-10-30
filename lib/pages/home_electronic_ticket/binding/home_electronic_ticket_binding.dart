import 'package:get/get.dart';

import '../../feature_electronic_ticket/history/data/history_provider.dart';
import '../../feature_electronic_ticket/history/data/history_repository.dart';
import '../../feature_electronic_ticket/history/domain/adapter/history_adapter.dart';
import '../../feature_electronic_ticket/history/presentation/controllers/history_controller.dart';
import '../../feature_electronic_ticket/list_type_ticket/data/series_provider.dart';
import '../../feature_electronic_ticket/list_type_ticket/data/series_repository.dart';
import '../../feature_electronic_ticket/list_type_ticket/domain/adapter/series_adapter.dart';
import '../../feature_electronic_ticket/list_type_ticket/presentation/controllers/list_type_ticket_controller.dart';
import '../presentation/controller/home_electronic_ticket_controller.dart';

class HomeElectronicTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeElectronicTicketController());

    /// list ticket binding
    Get.lazyPut(() => ListTypeTicketController(Get.find()));
    Get.lazyPut<ISeriesProvider>(() => SeriesProvider());
    Get.lazyPut<ISeriesRepository>(
        () => SeriesRepository(provider: Get.find()));

    /// history binding
    Get.lazyPut(() => HistoryController(Get.find(), Get.find()));
    Get.lazyPut<IHistoryProvider>(() => HistoryProvider());
    Get.lazyPut<IHistoryRepository>(
        () => HistoryRepository(provider: Get.find()));
  }
}
