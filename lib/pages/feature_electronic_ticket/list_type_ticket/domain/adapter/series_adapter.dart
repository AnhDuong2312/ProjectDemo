import '../entity/serial_entity.dart';

abstract class ISeriesRepository {
  Future<List<SerialEntity>> getSeries(Map<String, dynamic> param);
}
