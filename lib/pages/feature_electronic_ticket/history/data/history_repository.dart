import 'package:icorp_print_ticket/pages/feature_electronic_ticket/history/data/response/history_response.dart';

import '../domain/adapter/history_adapter.dart';
import '../domain/entity/history_entity.dart';
import 'history_provider.dart';
import 'mapper/history_mapper.dart';

class HistoryRepository implements IHistoryRepository {
  final IHistoryProvider provider;

  HistoryRepository({required this.provider});

  @override
  Future<Map<String, dynamic>> getHistory(Map<String, dynamic> param) async {
    final response = await provider.getSeries("ticket/list", param);
    var result = HistoryMapper.convert(HistoriesResponse.fromJson(response));
    return result;
  }
}
