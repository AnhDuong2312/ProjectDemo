// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_petroleum_invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPetroleumInvoiceResponse _$ListPetroleumInvoiceResponseFromJson(
        Map<String, dynamic> json) =>
    ListPetroleumInvoiceResponse(
      result: json['result'] as String?,
      rowLength: json['rowLength'] as int?,
      rowTotalCost: (json['rowTotalCost'] as num?)?.toDouble(),
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => PetroleumInvoiceInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$ListPetroleumInvoiceResponseToJson(
        ListPetroleumInvoiceResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'rowLength': instance.rowLength,
      'rowTotalCost': instance.rowTotalCost,
      'count': instance.count,
      'rows': instance.rows?.map((e) => e.toJson()).toList(),
    };

PetroleumInvoiceInfo _$PetroleumInvoiceInfoFromJson(
        Map<String, dynamic> json) =>
    PetroleumInvoiceInfo(
      invoiceId: json['invoiceId'] as int?,
      issueStatus: json['issueStatus'] as String?,
      serial: json['serial'] as String?,
      customerTaxCode: json['customerTaxCode'] as String?,
      no: json['no'] as int?,
      date: json['date'] as String?,
      totalAfterTax: (json['totalAfterTax'] as num?)?.toDouble(),
      customerEmail: json['customerEmail'] as String?,
      customerName: json['customerName'] as String?,
      customerCompanyName: json['customerCompanyName'] as String?,
    );

Map<String, dynamic> _$PetroleumInvoiceInfoToJson(
        PetroleumInvoiceInfo instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'issueStatus': instance.issueStatus,
      'serial': instance.serial,
      'customerTaxCode': instance.customerTaxCode,
      'no': instance.no,
      'date': instance.date,
      'totalAfterTax': instance.totalAfterTax,
      'customerEmail': instance.customerEmail,
      'customerName': instance.customerName,
      'customerCompanyName': instance.customerCompanyName,
    };
