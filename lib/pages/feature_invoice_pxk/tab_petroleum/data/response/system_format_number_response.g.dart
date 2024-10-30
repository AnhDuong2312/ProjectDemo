// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_format_number_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSystemFormatNumberResponse _$ListSystemFormatNumberResponseFromJson(
        Map<String, dynamic> json) =>
    ListSystemFormatNumberResponse(
      result: json['result'] as String?,
      total: json['total'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) =>
              SystemFormatNumberResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListSystemFormatNumberResponseToJson(
        ListSystemFormatNumberResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'total': instance.total,
      'rows': instance.rows?.map((e) => e.toJson()).toList(),
    };

SystemFormatNumberResponse _$SystemFormatNumberResponseFromJson(
        Map<String, dynamic> json) =>
    SystemFormatNumberResponse(
      systemFormatNumberId: json['systemFormatNumberId'] as int?,
      currencyExchange: json['currencyExchange'] as int?,
      exchangeRate: json['exchangeRate'] as int?,
      foreignCurrency: json['foreignCurrency'] as int?,
      ratio: json['ratio'] as int?,
      quantity: json['quantity'] as int?,
      conversionUnitPrice: json['conversionUnitPrice'] as int?,
      currencyUnitPrice: json['currencyUnitPrice'] as int?,
      unitPrice: json['unitPrice'] as int?,
      totalAmount: json['totalAmount'] as int?,
      totalCost: json['totalCost'] as int?,
      companyId: json['companyId'] as int?,
    );

Map<String, dynamic> _$SystemFormatNumberResponseToJson(
        SystemFormatNumberResponse instance) =>
    <String, dynamic>{
      'systemFormatNumberId': instance.systemFormatNumberId,
      'currencyExchange': instance.currencyExchange,
      'exchangeRate': instance.exchangeRate,
      'foreignCurrency': instance.foreignCurrency,
      'ratio': instance.ratio,
      'quantity': instance.quantity,
      'conversionUnitPrice': instance.conversionUnitPrice,
      'currencyUnitPrice': instance.currencyUnitPrice,
      'unitPrice': instance.unitPrice,
      'totalAmount': instance.totalAmount,
      'totalCost': instance.totalCost,
      'companyId': instance.companyId,
    };
