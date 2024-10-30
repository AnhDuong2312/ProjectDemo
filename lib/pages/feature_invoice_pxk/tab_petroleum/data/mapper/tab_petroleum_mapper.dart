import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/response/information_seller_response.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/data/response/search_tax_response.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/information_seller_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/search_tax_entity.dart';
import 'package:icorp_print_ticket/pages/feature_invoice_pxk/tab_petroleum/domain/enties/type_petroleum_entity.dart';
import 'package:intl/intl.dart';
import '../../domain/enties/system_format_number_entity.dart';
import '../response/production_response.dart';
import '../response/system_format_number_response.dart';

class TabPetroleumMapper {
  static List<TypePetroleumEntity> convertProducts(
      ListProductionResponse response) {
    return response.goods!
        .map((e) => TypePetroleumEntity(
            active: e.status,
            id: e.goodsId!,
            name: e.name ?? "",
            // price: e.price ?? 0,
            price: (e.priceAfterTax ?? false)
                ? ((e.price ?? 0) / 1.1)
                : (e.price ?? 0),
            unitName: e.unit ?? "",
            vat: double.parse(e.vat ?? "0"),
            code: e.code ?? ""))
        .toList()
        .where((element) => element.active == "ACTIVE")
        .toList();
  }

  static List<SystemFormatNumberEntity> convertSystemFormatNumbers(
      ListSystemFormatNumberResponse response) {
    return response.rows!
        .map((e) => SystemFormatNumberEntity(
            quantity: e.quantity ?? 0,
            unitPrice: e.quantity ?? 0,
            totalAmount: e.quantity ?? 0,
            totalCost: e.quantity ?? 0))
        .toList();
  }

  static InformationSellerEntity convertInformationSeller(
      InformationSellerResponse response) {
    return InformationSellerEntity(
        sellerName: response.company!.companyName ?? "",
        sellerTaxCode: response.company!.taxCode ?? "",
        sellerFullAddress: response.company!.businessPermitAddress ?? "",
        sellerPhone: response.company!.contactPersonPhone ?? "",
        sellerEmail: response.company!.contactPersonEmail ?? "",
        sellerAccountNumber: '',
        sellerBankName: response.company!.bankName ?? "");
  }

  static SearchTaxEntity convertSearchTax(SearchTaxResponse response) {
    return SearchTaxEntity(
        tax: response.data!.taxCode!,
        nameCompany: response.data!.companyName ?? "",
        address: response.data!.address ?? "",
        namePerson: response.data!.legalRepresentative ?? "",
        email: response.data!.email ?? "");
  }
}
