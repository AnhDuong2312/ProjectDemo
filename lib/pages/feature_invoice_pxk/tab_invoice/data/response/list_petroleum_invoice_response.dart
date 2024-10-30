import 'package:json_annotation/json_annotation.dart';

part 'list_petroleum_invoice_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ListPetroleumInvoiceResponse {
  String? result;
  int? rowLength;
  double? rowTotalCost;
  int? count;
  List<PetroleumInvoiceInfo>? rows;

  ListPetroleumInvoiceResponse(
      {this.result, this.rowLength, this.rowTotalCost, this.rows, this.count});

  factory ListPetroleumInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ListPetroleumInvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListPetroleumInvoiceResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PetroleumInvoiceInfo {
  int? invoiceId;
  String? issueStatus;
  String? serial;
  String? customerTaxCode;
  int? no;
  String? date;
  double? totalAfterTax;
  String? customerEmail;
  String? customerName;
  String? customerCompanyName;

  PetroleumInvoiceInfo(
      {this.invoiceId,
      this.issueStatus,
      this.serial,
      this.customerTaxCode,
      this.no,
      this.date,
      this.totalAfterTax,
      this.customerEmail,
      this.customerName,
      this.customerCompanyName});

  factory PetroleumInvoiceInfo.fromJson(Map<String, dynamic> json) =>
      _$PetroleumInvoiceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PetroleumInvoiceInfoToJson(this);
}
