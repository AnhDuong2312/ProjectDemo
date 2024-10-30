// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProductionResponse _$ListProductionResponseFromJson(
        Map<String, dynamic> json) =>
    ListProductionResponse(
      result: json['result'] as String?,
      total: json['total'] as int?,
      goods: (json['goods'] as List<dynamic>?)
          ?.map((e) => ProductionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListProductionResponseToJson(
        ListProductionResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'total': instance.total,
      'goods': instance.goods?.map((e) => e.toJson()).toList(),
    };

ProductionResponse _$ProductionResponseFromJson(Map<String, dynamic> json) =>
    ProductionResponse(
      goodsId: json['goodsId'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      numericalOrder: json['numericalOrder'] as int?,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      vat: json['vat'] as String?,
      discountRate: json['discountRate'] as int?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      priceAfterTax: json['priceAfterTax'] as bool?,
      companyId: json['companyId'] as int?,
      goodsGroupId: json['goodsGroupId'] as int?,
      goodsGroup: json['goodsGroup'],
    );

Map<String, dynamic> _$ProductionResponseToJson(ProductionResponse instance) =>
    <String, dynamic>{
      'goodsId': instance.goodsId,
      'code': instance.code,
      'name': instance.name,
      'numericalOrder': instance.numericalOrder,
      'unit': instance.unit,
      'price': instance.price,
      'vat': instance.vat,
      'discountRate': instance.discountRate,
      'description': instance.description,
      'status': instance.status,
      'priceAfterTax': instance.priceAfterTax,
      'companyId': instance.companyId,
      'goodsGroupId': instance.goodsGroupId,
      'goodsGroup': instance.goodsGroup,
    };
