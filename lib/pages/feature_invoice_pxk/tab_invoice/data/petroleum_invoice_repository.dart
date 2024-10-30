import 'package:intl/intl.dart';

import '../../tab_petroleum/data/mapper/tab_petroleum_mapper.dart';
import '../../tab_petroleum/data/response/production_response.dart';
import '../../tab_petroleum/domain/enties/type_petroleum_entity.dart';
import '../domain/entity/petroleum_invoice_entity.dart';
import '../domain/entity/petroleum_invoice_view_model.dart';
import 'petroleum_invoice_provider.dart';
import 'response/list_petroleum_invoice_response.dart';

abstract class IPetroleumInvoiceRepository {
  Future<PetroleumInvoiceViewModel> fetchPetroleumInvoices(
      Map<String, dynamic> params);

  Future<dynamic> sendEmail(Map<String, dynamic> params);

  Future<List<TypePetroleumEntity>> fetchGoodTypes(Map<String, dynamic> params);

  Future<dynamic> exportPdf(String? ticketId);
}

class PetroleumInvoiceRepository implements IPetroleumInvoiceRepository {
  final IPetroleumInvoiceProvider provider;

  PetroleumInvoiceRepository({required this.provider});

  @override
  Future<PetroleumInvoiceViewModel> fetchPetroleumInvoices(
      Map<String, dynamic> params) async {
    final response = await provider.fetchPetroleumInvoices(
        'invoice/list-all-in-app', params);
    final dataModel = ListPetroleumInvoiceResponse.fromJson(response);
    final invoces = (dataModel.rows ?? [])
        .map((e) => PetroleumInvoiceEntity(
            id: e.invoiceId,
            companyName: (e.customerCompanyName == null)
                ? e.customerName
                : (e.customerCompanyName!.isEmpty
                    ? e.customerName
                    : e.customerCompanyName),
            taxNumber: e.customerTaxCode,
            totalPrice: e.totalAfterTax,
            serial: e.serial,
            date: e.date != null
                ? DateFormat('yyyy/MM/dd').format(
                    DateTime.parse(e.date!).add(const Duration(hours: 7)))
                : "",
            invoiceNumber: e.no != null ? e.no!.toString() : null,
            customerEmail: e.customerEmail,
            customerName: e.customerName))
        .toList();
    return PetroleumInvoiceViewModel(
        invoiceAmount: dataModel.count,
        total: dataModel.rowTotalCost,
        invoices: invoces);
  }

  @override
  Future sendEmail(Map<String, dynamic> params) async {
    final response =
        await provider.sendEmail('invoice/send-invoice-to-customer', params);
    return response;
  }

  @override
  Future<List<TypePetroleumEntity>> fetchGoodTypes(
      Map<String, dynamic> params) async {
    final response = await provider.fetchGoodTypes('goods/find', params);
    var result = TabPetroleumMapper.convertProducts(
        ListProductionResponse.fromJson(response));
    return result;
  }

  @override
  Future exportPdf(String? ticketId) async {
    final response = await provider.exportPdf(
      'invoice/export/$ticketId',
    );
    return response;
  }
}
