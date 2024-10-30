import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/data/ds_log_provider.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/domain/entity/nozzle_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_dslog/domain/entity/station_entity.dart';
import 'package:intl/intl.dart';

import '../domain/entity/ds_log_entity.dart';
import '../domain/entity/list_log_view_model.dart';
import 'response/list_log_response.dart';
import 'response/list_station_response.dart';

abstract class IDSLogRepository {
  Future<ListLogViewModel> fetchLogs(Map<String, dynamic> params);
  Future<List<StationEntity>> fetchStations(Map<String, dynamic> params);
}

class DSLogRepository implements IDSLogRepository {
  final IDSLogProvider provider;

  DSLogRepository({required this.provider});

  @override
  Future<ListLogViewModel> fetchLogs(Map<String, dynamic> params) async {
    final response = await provider.fetchLogs('data-log/list', params);
    final dataModel = ListLogResponse.fromJson(response);
    if (dataModel.data == null) {
      return ListLogViewModel(total: 0, logAmount: 0, logs: []);
    }
    final logs = (dataModel.data!.dataLogPetros ?? [])
        .map((e) => DSLogEntity(
            id: e.dataLogPetroId,
            petroleumType: e.productName,
            price: e.unitPriceAfterTax,
            amount: e.quantity,
            timeCreated: e.createdAt != null
                ? DateFormat('yyyy/MM/dd hh:mm').format(
                    DateTime.parse(e.createdAt!).add(const Duration(hours: 7)))
                : "",
            totalPrice: e.totalAmountAfterTax,
            nozzle: e.nozzleName ?? e.nozzleCode,
            status: e.status,
            isMarked: e.isMarked))
        .toList();
    return ListLogViewModel(
        total: dataModel.data!.totalCost,
        logAmount: dataModel.data!.total,
        logs: logs);
  }

  @override
  Future<List<StationEntity>> fetchStations(Map<String, dynamic> params) async {
    final response = await provider.fetchLogs('station-petro/list', params);
    final dataModel = ListStationResponse.fromJson(response);
    if (dataModel.data == null) {
      return [];
    }
    final stations = (dataModel.data!.stationPetros ?? [])
        .map((e) => StationEntity(
            code: e.stationCode,
            name: e.stationName,
            nozzles: (e.nozzles ?? [])
                .map((e) => NozzleEntity(
                    code: e.nozzleCode.toString(),
                    name: e.nozzleName ?? e.nozzleCode))
                .toList()))
        .toList();
    return stations;
  }
}
