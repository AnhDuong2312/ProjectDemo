import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/mapper/tab_petroleum_mapper.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/response/information_seller_response.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/response/production_response.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/response/search_tax_response.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/response/system_format_number_response.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/information_seller_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/search_tax_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/type_petroleum_entity.dart';

import '../domain/adapter/tab_petroleum_adapter.dart';
import '../domain/enties/system_format_number_entity.dart';
import 'tab_petroleum_provider.dart';

class TabPetroleumRepository implements ITabPetroleumRepository {
  final ITabPetroleumProvider provider;

  TabPetroleumRepository({required this.provider});

  @override
  Future<List<TypePetroleumEntity>> getProducts(
      Map<String, dynamic> params) async {
    final response = await provider.getProducts('goods/find', params);
    var result = TabPetroleumMapper.convertProducts(
        ListProductionResponse.fromJson(response));
    return result;
  }

  @override
  Future<SystemFormatNumberEntity> getSystemFormatNumbers() async {
    final response = await provider.getSystemFormatNumbers(
      'systemFormatNumber-app',
    );
    var resultParse = TabPetroleumMapper.convertSystemFormatNumbers(
        ListSystemFormatNumberResponse.fromJson(response));
    if (resultParse.isEmpty) {
      return SystemFormatNumberEntity(
          quantity: 0, totalAmount: 0, totalCost: 0, unitPrice: 0);
    }
    return resultParse[0];
  }

  @override
  Future<dynamic> createInvoice(Map<String, dynamic> params) async {
    final response = await provider.createInvoice('invoice/create', params);

    return response;
  }

  @override
  Future<dynamic> hsmInvoiceSign(Map<String, dynamic> params) async {
    final response = await provider.hsmInvoiceSign(
        'invoice/hsm-invoices-sign-single', params);

    return response;
  }

  @override
  Future<InformationSellerEntity> getInformationSeller() async {
    final response = await provider.getInformationSeller('account/me', {});
    return TabPetroleumMapper.convertInformationSeller(
        InformationSellerResponse.fromJson(response));
  }

  @override
  Future sendEmail(Map<String, dynamic> params) async {
    final response =
        await provider.sendEmail('invoice/send-invoice-to-customer', params);
    return response;
  }

  @override
  Future viewDraftTicket(Map<String, dynamic> params) async {
    final response = await provider.viewDraftTicket('invoice/export', params);
    return response;
  }

  @override
  Future<SearchTaxEntity> searchTax(Map<String, dynamic> params) async {
    final response = await provider.searchTax('misc/tax-code', params);

    return TabPetroleumMapper.convertSearchTax(
        SearchTaxResponse.fromJson(response));
  }

  @override
  Future createInvoiceDataLog(Map<String, dynamic> params) async {
    final response = await provider.createInvoiceDataLog(
        'invoice/create-from-log-petro', params);
    return response;
  }

  @override
  Future<String> numberToWord(Map<String, dynamic> params) async {
    final response = await provider.numberToWord('misc/number-to-word', params);
    return (response as Map).containsKey("data") ? response["data"] : "";
  }

  @override
  Future<String> fetchNameConfig(Map<String, dynamic> params) async {
    final response =
        await provider.fetchNameConfig('data-log-config/detail', params);
    if ((response as Map).containsKey("data")) {
      final dataMap = response["data"];
      return (dataMap as Map).containsKey("customerName")
          ? (dataMap["customerName"] ?? "")
          : "";
    }
    return '';
  }
}
