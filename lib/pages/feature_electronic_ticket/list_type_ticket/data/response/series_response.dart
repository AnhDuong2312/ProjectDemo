import 'package:json_annotation/json_annotation.dart';

part 'series_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class SeriesResponse {
  String? result;
  int? count;
  List<SerialModelResponse>? templates;

  SeriesResponse(this.result, this.count, this.templates);

  factory SeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SerialModelResponse {
  int? invoiceTemplateId;
  String? name;
  int? form;
  String? hasTaCode;
  int? year;
  String? managementCode;
  String? type;
  double? ticketPrice;
  String? currencyUnit;
  String? vatRateTicket;

  SerialModelResponse(
      {this.invoiceTemplateId,
      this.name,
      this.form,
      this.hasTaCode,
      this.year,
      this.type,
      this.managementCode,
      this.ticketPrice,
      this.currencyUnit});

  factory SerialModelResponse.fromJson(Map<String, dynamic> json) =>
      _$SerialModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SerialModelResponseToJson(this);
}
