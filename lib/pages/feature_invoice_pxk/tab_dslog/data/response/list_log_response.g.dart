// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_log_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListLogResponse _$ListLogResponseFromJson(Map<String, dynamic> json) =>
    ListLogResponse(
      result: json['result'] as String?,
      data: json['data'] == null
          ? null
          : DataLog.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListLogResponseToJson(ListLogResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data?.toJson(),
    };

DataLog _$DataLogFromJson(Map<String, dynamic> json) => DataLog(
      count: json['count'] as int?,
      totalCost: (json['totalCost'] as num?)?.toDouble(),
      dataLogPetros: (json['dataLogPetros'] as List<dynamic>?)
          ?.map((e) => LogPetroInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int?,
    );

Map<String, dynamic> _$DataLogToJson(DataLog instance) => <String, dynamic>{
      'count': instance.count,
      'totalCost': instance.totalCost,
      'dataLogPetros': instance.dataLogPetros?.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };

LogPetroInfo _$LogPetroInfoFromJson(Map<String, dynamic> json) => LogPetroInfo(
      dataLogPetroId: json['dataLogPetroId'] as int?,
      companyId: json['companyId'] as int?,
      companyTaxCode: json['companyTaxCode'] as String?,
      stationCode: json['stationCode'] as String?,
      stationName: json['stationName'] as String?,
      saleNumber: json['saleNumber'] as String?,
      createdAt: json['createdAt'] as String?,
      nozzleCode: json['nozzleCode'] as String?,
      nozzleName: json['nozzleName'] as String?,
      partnerKey: json['partnerKey'] as int?,
      status: json['status'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unitPriceAfterTax: (json['unitPriceAfterTax'] as num?)?.toDouble(),
      totalAmountAfterTax: (json['totalAmountAfterTax'] as num?)?.toDouble(),
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      dataLogPetroOfDataLogPetroInvoice:
          (json['dataLogPetroOfDataLogPetroInvoice'] as List<dynamic>?)
              ?.map((e) => LogPetroInvoice.fromJson(e as Map<String, dynamic>))
              .toList(),
      isMarked: json['isMarked'] as bool?,
    );

Map<String, dynamic> _$LogPetroInfoToJson(LogPetroInfo instance) =>
    <String, dynamic>{
      'dataLogPetroId': instance.dataLogPetroId,
      'companyId': instance.companyId,
      'companyTaxCode': instance.companyTaxCode,
      'stationCode': instance.stationCode,
      'stationName': instance.stationName,
      'saleNumber': instance.saleNumber,
      'createdAt': instance.createdAt,
      'nozzleCode': instance.nozzleCode,
      'nozzleName': instance.nozzleName,
      'partnerKey': instance.partnerKey,
      'status': instance.status,
      'quantity': instance.quantity,
      'unitPriceAfterTax': instance.unitPriceAfterTax,
      'totalAmountAfterTax': instance.totalAmountAfterTax,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'dataLogPetroOfDataLogPetroInvoice': instance
          .dataLogPetroOfDataLogPetroInvoice
          ?.map((e) => e.toJson())
          .toList(),
      'isMarked': instance.isMarked,
    };

LogPetroInvoice _$LogPetroInvoiceFromJson(Map<String, dynamic> json) =>
    LogPetroInvoice(
      dataLogPetroId: json['dataLogPetroId'] as int?,
      dataLogPetroInvoiceId: json['dataLogPetroInvoiceId'] as int?,
      invoiceId: json['invoiceId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      dataLogPetroInvoiceByInvoice: json['dataLogPetroInvoiceByInvoice'] == null
          ? null
          : PetroleumInvoiceInfo.fromJson(
              json['dataLogPetroInvoiceByInvoice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LogPetroInvoiceToJson(LogPetroInvoice instance) =>
    <String, dynamic>{
      'dataLogPetroId': instance.dataLogPetroId,
      'dataLogPetroInvoiceId': instance.dataLogPetroInvoiceId,
      'invoiceId': instance.invoiceId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'dataLogPetroInvoiceByInvoice':
          instance.dataLogPetroInvoiceByInvoice?.toJson(),
    };
