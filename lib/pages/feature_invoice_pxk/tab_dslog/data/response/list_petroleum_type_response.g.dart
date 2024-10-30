// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_petroleum_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPetroleumTypeResponse _$ListPetroleumTypeResponseFromJson(
        Map<String, dynamic> json) =>
    ListPetroleumTypeResponse(
      result: json['result'] as String?,
      data: json['data'] == null
          ? null
          : DataPetroleumType.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListPetroleumTypeResponseToJson(
        ListPetroleumTypeResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data?.toJson(),
    };

DataPetroleumType _$DataPetroleumTypeFromJson(Map<String, dynamic> json) =>
    DataPetroleumType(
      count: json['count'] as int?,
      productNames: (json['productNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DataPetroleumTypeToJson(DataPetroleumType instance) =>
    <String, dynamic>{
      'count': instance.count,
      'productNames': instance.productNames,
    };
