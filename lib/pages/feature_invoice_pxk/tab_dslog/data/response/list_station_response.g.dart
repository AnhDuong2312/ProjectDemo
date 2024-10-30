// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_station_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListStationResponse _$ListStationResponseFromJson(Map<String, dynamic> json) =>
    ListStationResponse(
      result: json['result'] as String?,
      data: json['data'] == null
          ? null
          : DataStation.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListStationResponseToJson(
        ListStationResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data?.toJson(),
    };

DataStation _$DataStationFromJson(Map<String, dynamic> json) => DataStation(
      count: json['count'] as int?,
      total: (json['total'] as num?)?.toDouble(),
      stationPetros: (json['stationPetros'] as List<dynamic>?)
          ?.map((e) => StationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataStationToJson(DataStation instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'stationPetros': instance.stationPetros?.map((e) => e.toJson()).toList(),
    };

StationInfo _$StationInfoFromJson(Map<String, dynamic> json) => StationInfo(
      stationPetroId: json['stationPetroId'] as int?,
      stationCode: json['stationCode'] as String?,
      stationName: json['stationName'] as String?,
      nozzles: (json['nozzles'] as List<dynamic>?)
          ?.map((e) => NozzleInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StationInfoToJson(StationInfo instance) =>
    <String, dynamic>{
      'stationPetroId': instance.stationPetroId,
      'stationCode': instance.stationCode,
      'stationName': instance.stationName,
      'nozzles': instance.nozzles?.map((e) => e.toJson()).toList(),
    };

NozzleInfo _$NozzleInfoFromJson(Map<String, dynamic> json) => NozzleInfo(
      nozzleId: json['nozzleId'] as int?,
      stationPetroId: json['stationPetroId'] as int?,
      nozzleCode: json['nozzleCode'] as String?,
      nozzleName: json['nozzleName'] as String?,
    );

Map<String, dynamic> _$NozzleInfoToJson(NozzleInfo instance) =>
    <String, dynamic>{
      'nozzleId': instance.nozzleId,
      'stationPetroId': instance.stationPetroId,
      'nozzleCode': instance.nozzleCode,
      'nozzleName': instance.nozzleName,
    };
