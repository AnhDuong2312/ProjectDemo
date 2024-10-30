// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesResponse _$SeriesResponseFromJson(Map<String, dynamic> json) =>
    SeriesResponse(
      json['result'] as String?,
      json['count'] as int?,
      (json['templates'] as List<dynamic>?)
          ?.map((e) => SerialModelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeriesResponseToJson(SeriesResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'count': instance.count,
      'templates': instance.templates?.map((e) => e.toJson()).toList(),
    };

SerialModelResponse _$SerialModelResponseFromJson(Map<String, dynamic> json) =>
    SerialModelResponse(
      invoiceTemplateId: json['invoiceTemplateId'] as int?,
      name: json['name'] as String?,
      form: json['form'] as int?,
      hasTaCode: json['hasTaCode'] as String?,
      year: json['year'] as int?,
      type: json['type'] as String?,
      managementCode: json['managementCode'] as String?,
      ticketPrice: (json['ticketPrice'] as num?)?.toDouble(),
      currencyUnit: json['currencyUnit'] as String?,
    )..vatRateTicket = json['vatRateTicket'] as String?;

Map<String, dynamic> _$SerialModelResponseToJson(
        SerialModelResponse instance) =>
    <String, dynamic>{
      'invoiceTemplateId': instance.invoiceTemplateId,
      'name': instance.name,
      'form': instance.form,
      'hasTaCode': instance.hasTaCode,
      'year': instance.year,
      'managementCode': instance.managementCode,
      'type': instance.type,
      'ticketPrice': instance.ticketPrice,
      'currencyUnit': instance.currencyUnit,
      'vatRateTicket': instance.vatRateTicket,
    };
