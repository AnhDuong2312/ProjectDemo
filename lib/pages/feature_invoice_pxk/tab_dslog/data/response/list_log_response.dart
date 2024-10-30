import 'package:json_annotation/json_annotation.dart';

import '../../../tab_invoice/data/response/list_petroleum_invoice_response.dart';

part 'list_log_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ListLogResponse {
  String? result;
  DataLog? data;

  ListLogResponse({this.result, this.data});

  factory ListLogResponse.fromJson(Map<String, dynamic> json) =>
      _$ListLogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListLogResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataLog {
  int? count;
  double? totalCost;
  List<LogPetroInfo>? dataLogPetros;
  int? total;

  DataLog({this.count, this.totalCost, this.dataLogPetros, this.total});

  factory DataLog.fromJson(Map<String, dynamic> json) =>
      _$DataLogFromJson(json);

  Map<String, dynamic> toJson() => _$DataLogToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LogPetroInfo {
  int? dataLogPetroId;
  int? companyId;
  String? companyTaxCode;
  String? stationCode;
  String? stationName;
  String? saleNumber;
  String? createdAt;
  String? nozzleCode;
  String? nozzleName;
  int? partnerKey;
  String? status;
  double? quantity;
  double? unitPriceAfterTax;
  double? totalAmountAfterTax;
  String? productCode;
  String? productName;
  List<LogPetroInvoice>? dataLogPetroOfDataLogPetroInvoice;
  bool? isMarked;

  LogPetroInfo(
      {this.dataLogPetroId,
      this.companyId,
      this.companyTaxCode,
      this.stationCode,
      this.stationName,
      this.saleNumber,
      this.createdAt,
      this.nozzleCode,
      this.nozzleName,
      this.partnerKey,
      this.status,
      this.quantity,
      this.unitPriceAfterTax,
      this.totalAmountAfterTax,
      this.productCode,
      this.productName,
      this.dataLogPetroOfDataLogPetroInvoice,
      this.isMarked});

  factory LogPetroInfo.fromJson(Map<String, dynamic> json) =>
      _$LogPetroInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LogPetroInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LogPetroInvoice {
  int? dataLogPetroId;
  int? dataLogPetroInvoiceId;
  int? invoiceId;
  String? createdAt;
  String? updatedAt;
  PetroleumInvoiceInfo? dataLogPetroInvoiceByInvoice;

  LogPetroInvoice(
      {this.dataLogPetroId,
      this.dataLogPetroInvoiceId,
      this.invoiceId,
      this.createdAt,
      this.updatedAt,
      this.dataLogPetroInvoiceByInvoice});

  factory LogPetroInvoice.fromJson(Map<String, dynamic> json) =>
      _$LogPetroInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$LogPetroInvoiceToJson(this);
}
