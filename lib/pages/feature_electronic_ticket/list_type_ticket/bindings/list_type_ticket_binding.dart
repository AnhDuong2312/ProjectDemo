
import 'package:get/get.dart';

import '../data/series_provider.dart';
import '../data/series_repository.dart';
import '../domain/adapter/series_adapter.dart';
import '../presentation/controllers/list_type_ticket_controller.dart';

class ListTypeTicketBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ListTypeTicketController(Get.find()));
   Get.lazyPut<ISeriesProvider>(() => SeriesProvider());
   Get.lazyPut<ISeriesRepository>(() => SeriesRepository(provider: Get.find()));

  }

}