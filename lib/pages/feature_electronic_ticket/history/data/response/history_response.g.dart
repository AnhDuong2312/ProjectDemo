// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoriesResponse _$HistoriesResponseFromJson(Map<String, dynamic> json) =>
    HistoriesResponse(
      json['result'] as String?,
      json['count'] as int?,
      (json['rows'] as List<dynamic>?)
          ?.map((e) => HistoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sumTotalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoriesResponseToJson(HistoriesResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'count': instance.count,
      'rows': instance.rows?.map((e) => e.toJson()).toList(),
      'sumTotalPrice': instance.sumTotalPrice,
    };

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) =>
    HistoryResponse(
      ticketId: json['ticketId'] as int?,
      namePersonCreate: json['namePersonCreate'] as String?,
      noCar: json['noCar'] as String?,
      nameTicket: json['nameTicket'] as String?,
      createdAt: json['createdAt'] as String?,
      noPrint: json['noPrint'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'ticketId': instance.ticketId,
      'namePersonCreate': instance.namePersonCreate,
      'noCar': instance.noCar,
      'nameTicket': instance.nameTicket,
      'createdAt': instance.createdAt,
      'totalPrice': instance.totalPrice,
      'noPrint': instance.noPrint,
    };
