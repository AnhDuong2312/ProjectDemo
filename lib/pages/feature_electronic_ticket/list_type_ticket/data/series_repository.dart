

import 'package:icorp_print_ticket/pages/feature_electronic_ticket/list_type_ticket/data/response/series_response.dart';

import '../domain/adapter/series_adapter.dart';
import '../domain/entity/serial_entity.dart';
import 'mapper/serial_mapper.dart';
import 'series_provider.dart';

class SeriesRepository implements ISeriesRepository {
  final ISeriesProvider provider;

  SeriesRepository({required this.provider});

  @override
  Future<List<SerialEntity>> getSeries(Map<String, dynamic> param) async {
    final response = await provider.getSeries('template', param);
    var result = SerialMapper.convert(SeriesResponse.fromJson(response));
    return result;
  }
}
