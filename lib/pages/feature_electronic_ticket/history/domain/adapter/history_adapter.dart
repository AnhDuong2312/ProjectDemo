import '../entity/history_entity.dart';

abstract class IHistoryRepository {
  Future<Map<String, dynamic>> getHistory(Map<String, dynamic> param);
}
