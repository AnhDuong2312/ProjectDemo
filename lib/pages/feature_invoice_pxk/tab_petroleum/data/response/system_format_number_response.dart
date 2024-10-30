import 'package:json_annotation/json_annotation.dart';

part 'system_format_number_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ListSystemFormatNumberResponse {
  String? result;
  int? total;
  List<SystemFormatNumberResponse>? rows;

  ListSystemFormatNumberResponse({this.result, this.total, this.rows});

  factory ListSystemFormatNumberResponse.fromJson(Map<String, dynamic> json) =>
      _$ListSystemFormatNumberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListSystemFormatNumberResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SystemFormatNumberResponse {
  int? systemFormatNumberId;
  int? currencyExchange;
  int? exchangeRate;
  int? foreignCurrency;
  int? ratio;
  int? quantity;
  int? conversionUnitPrice;
  int? currencyUnitPrice;
  int? unitPrice;
  int? totalAmount;
  int? totalCost;
  int? companyId;

  SystemFormatNumberResponse(
      {this.systemFormatNumberId,
      this.currencyExchange,
      this.exchangeRate,
      this.foreignCurrency,
      this.ratio,
      this.quantity,
      this.conversionUnitPrice,
      this.currencyUnitPrice,
      this.unitPrice,
      this.totalAmount,
      this.totalCost,
      this.companyId});

  factory SystemFormatNumberResponse.fromJson(Map<String, dynamic> json) =>
      _$SystemFormatNumberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SystemFormatNumberResponseToJson(this);
}
