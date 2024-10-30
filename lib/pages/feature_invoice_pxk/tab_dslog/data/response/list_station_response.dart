import 'package:json_annotation/json_annotation.dart';

part 'list_station_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ListStationResponse {
  String? result;
  DataStation? data;

  ListStationResponse({this.result, this.data});

  factory ListStationResponse.fromJson(Map<String, dynamic> json) =>
      _$ListStationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListStationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataStation {
  int? count;
  double? total;
  List<StationInfo>? stationPetros;

  DataStation({this.count, this.total, this.stationPetros});

  factory DataStation.fromJson(Map<String, dynamic> json) =>
      _$DataStationFromJson(json);

  Map<String, dynamic> toJson() => _$DataStationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StationInfo {
  int? stationPetroId;
  String? stationCode;
  String? stationName;
  List<NozzleInfo>? nozzles;

  StationInfo(
      {this.stationPetroId, this.stationCode, this.stationName, this.nozzles});

  factory StationInfo.fromJson(Map<String, dynamic> json) =>
      _$StationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StationInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NozzleInfo {
  int? nozzleId;
  int? stationPetroId;
  String? nozzleCode;
  String? nozzleName;

  NozzleInfo(
      {this.nozzleId, this.stationPetroId, this.nozzleCode, this.nozzleName});

  factory NozzleInfo.fromJson(Map<String, dynamic> json) =>
      _$NozzleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$NozzleInfoToJson(this);
}
