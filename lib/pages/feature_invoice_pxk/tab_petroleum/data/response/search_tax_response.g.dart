// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_tax_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchTaxResponse _$SearchTaxResponseFromJson(Map<String, dynamic> json) =>
    SearchTaxResponse(
      result: json['result'] as String?,
      data: json['data'] == null
          ? null
          : SearchTaxDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchTaxResponseToJson(SearchTaxResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data?.toJson(),
    };

SearchTaxDataResponse _$SearchTaxDataResponseFromJson(
        Map<String, dynamic> json) =>
    SearchTaxDataResponse(
      companyName: json['companyName'] as String?,
      internationalName: json['internationalName'] as String?,
      abbreviatedName: json['abbreviatedName'] as String?,
      taxCode: json['taxCode'] as String?,
      address: json['address'] as String?,
      country: json['country'] as String?,
      province: json['province'] as String?,
      district: json['district'] as String?,
      commune: json['commune'] as String?,
      street: json['street'] as String?,
      legalRepresentative: json['legalRepresentative'] as String?,
      position: json['position'] as String?,
      gender: json['gender'] as String?,
      legalDocumentType: json['legalDocumentType'] as String?,
      legalDocumentValue: json['legalDocumentValue'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      dateOfOperation: json['dateOfOperation'] as String?,
      managedBy: json['managedBy'] as String?,
      registrationPlace: json['registrationPlace'] as String?,
      charteredCapital: json['charteredCapital'] as String?,
      businessType: json['businessType'] as String?,
      link: json['link'] as String?,
      source: json['source'] as String?,
      status: json['status'] as String?,
      noBusiness: json['noBusiness'] as bool?,
      cccd: json['cccd'] as String?,
    );

Map<String, dynamic> _$SearchTaxDataResponseToJson(
        SearchTaxDataResponse instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'internationalName': instance.internationalName,
      'abbreviatedName': instance.abbreviatedName,
      'taxCode': instance.taxCode,
      'address': instance.address,
      'country': instance.country,
      'province': instance.province,
      'district': instance.district,
      'commune': instance.commune,
      'street': instance.street,
      'legalRepresentative': instance.legalRepresentative,
      'position': instance.position,
      'gender': instance.gender,
      'legalDocumentType': instance.legalDocumentType,
      'legalDocumentValue': instance.legalDocumentValue,
      'phone': instance.phone,
      'email': instance.email,
      'dateOfOperation': instance.dateOfOperation,
      'managedBy': instance.managedBy,
      'registrationPlace': instance.registrationPlace,
      'charteredCapital': instance.charteredCapital,
      'businessType': instance.businessType,
      'link': instance.link,
      'source': instance.source,
      'status': instance.status,
      'noBusiness': instance.noBusiness,
      'cccd': instance.cccd,
    };
