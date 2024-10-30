import 'package:json_annotation/json_annotation.dart';

part 'list_petroleum_type_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ListPetroleumTypeResponse {
  String? result;
  DataPetroleumType? data;

  ListPetroleumTypeResponse({this.result, this.data});

  factory ListPetroleumTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ListPetroleumTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListPetroleumTypeResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataPetroleumType {
  int? count;
  List<String>? productNames;

  DataPetroleumType({this.count, this.productNames});

  factory DataPetroleumType.fromJson(Map<String, dynamic> json) =>
      _$DataPetroleumTypeFromJson(json);

  Map<String, dynamic> toJson() => _$DataPetroleumTypeToJson(this);
}
