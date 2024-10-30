import 'package:intl/intl.dart';

import '../../domain/entity/history_entity.dart';
import '../response/history_response.dart';

class HistoryMapper {
  static Map<String, dynamic> convert(HistoriesResponse response) {
    return {
      "data": response.rows!
          .map((e) => HistoryEntity(
              id: e.ticketId,
              licenceTemplate: e.noCar ?? "",
              timeCreated: e.createdAt != null
                  ? DateFormat('yyyy-MM-dd HH:mm')
                      .format(DateTime.parse(e.createdAt!).add(const Duration(hours: 7)))
                  : "",
              typeTicket: e.nameTicket ?? "",
              namePersonCreate: e.namePersonCreate,
              noPrint: e.noPrint,
              totalPrice: e.totalPrice))
          .toList(),
      "count": response.count ?? 0,
      "sumTotalPrice": response.sumTotalPrice ?? 0.0
    };
  }
}
