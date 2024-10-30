import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/information_seller_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/type_petroleum_entity.dart';

import '../enties/search_tax_entity.dart';
import '../enties/system_format_number_entity.dart';

abstract class ITabPetroleumRepository {
  Future<List<TypePetroleumEntity>> getProducts(Map<String, dynamic> params);

  Future<SystemFormatNumberEntity> getSystemFormatNumbers();

  Future<dynamic> createInvoice(Map<String, dynamic> params);

  Future<dynamic> hsmInvoiceSign(Map<String, dynamic> params);

  Future<InformationSellerEntity> getInformationSeller();

  Future<dynamic> sendEmail(Map<String, dynamic> params);

  Future<dynamic> viewDraftTicket(Map<String, dynamic> params);

  Future<SearchTaxEntity> searchTax(Map<String, dynamic> params);

  Future<dynamic> createInvoiceDataLog(Map<String, dynamic> params);

  Future<String> numberToWord(Map<String, dynamic> params);

  Future<String> fetchNameConfig(Map<String, dynamic> params);
}
