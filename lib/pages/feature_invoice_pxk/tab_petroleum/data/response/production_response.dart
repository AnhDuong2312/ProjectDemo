import 'package:json_annotation/json_annotation.dart';

part 'production_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class ListProductionResponse {
  String? result;
  int? total;
  List<ProductionResponse>? goods;

  ListProductionResponse({this.result, this.total, this.goods});

  factory ListProductionResponse.fromJson(Map<String, dynamic> json) =>
      _$ListProductionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListProductionResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductionResponse {
  int? goodsId;
  String ?code;
  String? name;
  int? numericalOrder;
  String? unit;
  double? price;
  String ?vat;
  int? discountRate;
  String? description;
  String? status;
  bool? priceAfterTax;
  int? companyId;
  int ?goodsGroupId;
  dynamic goodsGroup;

  ProductionResponse(
      {this.goodsId,
        this.code,
        this.name,
        this.numericalOrder,
        this.unit,
        this.price,
        this.vat,
        this.discountRate,
        this.description,
        this.status,
        this.priceAfterTax,
        this.companyId,
        this.goodsGroupId,
        this.goodsGroup});

  factory ProductionResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionResponseToJson(this);
}
