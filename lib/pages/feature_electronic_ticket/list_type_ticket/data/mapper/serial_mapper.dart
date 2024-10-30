import '../../domain/entity/serial_entity.dart';
import '../response/series_response.dart';

class SerialMapper {
  static List<SerialEntity> convert(SeriesResponse response) {
    return response.templates!
        .map((e) => SerialEntity(
            id: e.invoiceTemplateId,
            name: e.name ?? "",
            price: e.ticketPrice ?? 0,
            symbol:
                '${e.form}${e.hasTaCode}${e.year}${e.type}${e.managementCode}',
            rateTax: double.parse(e.vatRateTicket ?? "0")))
        .toList();
  }
}
