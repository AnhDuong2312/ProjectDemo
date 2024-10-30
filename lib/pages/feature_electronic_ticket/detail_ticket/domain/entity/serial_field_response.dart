import 'package:json_annotation/json_annotation.dart';

part 'serial_field_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class SerialFieldResponse {
  String code;
  String message;
  SerialFieldModel? data;

  SerialFieldResponse(this.code, this.message, this.data);

  factory SerialFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$SerialFieldResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SerialFieldResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class SerialFieldModel {
  List<SerialFieldDetailResponse>? ttchung;
  InformationOtherModel? ttkhac;

  SerialFieldModel({this.ttchung, this.ttkhac});

  factory SerialFieldModel.fromJson(Map<String, dynamic> json) =>
      _$SerialFieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$SerialFieldModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class InformationOtherModel {
  List<SerialFieldDetailResponse>? dauphieu;
  List<SerialFieldDetailResponse>? chitiet;

  InformationOtherModel({this.dauphieu, this.chitiet});

  factory InformationOtherModel.fromJson(Map<String, dynamic> json) =>
      _$InformationOtherModelFromJson(json);

  Map<String, dynamic> toJson() => _$InformationOtherModelToJson(this);
}



@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class SerialFieldDetailResponse {
  String? fieldName;
  String? label;
  String? length;
  String? type;
  List<ItemSelectModel>? value;


  SerialFieldDetailResponse(this.fieldName, this.label, this.length, this.type, this.value);

  factory SerialFieldDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SerialFieldDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SerialFieldDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ItemSelectModel {
  String? ma;
  String? ten;
  ItemSelectModel(this.ma, this.ten, );

  factory ItemSelectModel.fromJson(Map<String, dynamic> json) =>
      _$ItemSelectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSelectModelToJson(this);
}



@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class GetIdPrintResponse {
  String? code;
  String? message;
  List<String>? data;


  GetIdPrintResponse(this.code, this.message, this.data);

  factory GetIdPrintResponse.fromJson(Map<String, dynamic> json) =>
      _$GetIdPrintResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetIdPrintResponseToJson(this);
}

