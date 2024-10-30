// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serial_field_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerialFieldResponse _$SerialFieldResponseFromJson(Map<String, dynamic> json) =>
    SerialFieldResponse(
      json['code'] as String,
      json['message'] as String,
      json['data'] == null
          ? null
          : SerialFieldModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SerialFieldResponseToJson(
        SerialFieldResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

SerialFieldModel _$SerialFieldModelFromJson(Map<String, dynamic> json) =>
    SerialFieldModel(
      ttchung: (json['ttchung'] as List<dynamic>?)
          ?.map((e) =>
              SerialFieldDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      ttkhac: json['ttkhac'] == null
          ? null
          : InformationOtherModel.fromJson(
              json['ttkhac'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SerialFieldModelToJson(SerialFieldModel instance) =>
    <String, dynamic>{
      'ttchung': instance.ttchung?.map((e) => e.toJson()).toList(),
      'ttkhac': instance.ttkhac?.toJson(),
    };

InformationOtherModel _$InformationOtherModelFromJson(
        Map<String, dynamic> json) =>
    InformationOtherModel(
      dauphieu: (json['dauphieu'] as List<dynamic>?)
          ?.map((e) =>
              SerialFieldDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      chitiet: (json['chitiet'] as List<dynamic>?)
          ?.map((e) =>
              SerialFieldDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InformationOtherModelToJson(
        InformationOtherModel instance) =>
    <String, dynamic>{
      'dauphieu': instance.dauphieu?.map((e) => e.toJson()).toList(),
      'chitiet': instance.chitiet?.map((e) => e.toJson()).toList(),
    };

SerialFieldDetailResponse _$SerialFieldDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SerialFieldDetailResponse(
      json['fieldName'] as String?,
      json['label'] as String?,
      json['length'] as String?,
      json['type'] as String?,
      (json['value'] as List<dynamic>?)
          ?.map((e) => ItemSelectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SerialFieldDetailResponseToJson(
        SerialFieldDetailResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'length': instance.length,
      'type': instance.type,
      'value': instance.value?.map((e) => e.toJson()).toList(),
    };

ItemSelectModel _$ItemSelectModelFromJson(Map<String, dynamic> json) =>
    ItemSelectModel(
      json['ma'] as String?,
      json['ten'] as String?,
    );

Map<String, dynamic> _$ItemSelectModelToJson(ItemSelectModel instance) =>
    <String, dynamic>{
      'ma': instance.ma,
      'ten': instance.ten,
    };

GetIdPrintResponse _$GetIdPrintResponseFromJson(Map<String, dynamic> json) =>
    GetIdPrintResponse(
      json['code'] as String?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetIdPrintResponseToJson(GetIdPrintResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
