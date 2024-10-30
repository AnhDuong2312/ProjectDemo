import 'package:json_annotation/json_annotation.dart';

part 'search_tax_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class SearchTaxResponse {
  String? result;
  SearchTaxDataResponse? data;

  SearchTaxResponse({
    this.result,
    this.data,
  });

  factory SearchTaxResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTaxResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTaxResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchTaxDataResponse {
  String? companyName;
  String? internationalName;
  String? abbreviatedName;
  String? taxCode;
  String? address;
  String? country;
  String? province;
  String? district;
  String? commune;
  String? street;
  String? legalRepresentative;
  String? position;
  String? gender;
  String? legalDocumentType;
  String? legalDocumentValue;
  String? phone;
  String? email;
  String? dateOfOperation;
  String? managedBy;
  String? registrationPlace;
  String? charteredCapital;
  String? businessType;
  String? link;
  String? source;
  String? status;
  bool? noBusiness;
  String? cccd;

  SearchTaxDataResponse({
    this.companyName,
    this.internationalName,
    this.abbreviatedName,
    this.taxCode,
    this.address,
    this.country,
    this.province,
    this.district,
    this.commune,
    this.street,
    this.legalRepresentative,
    this.position,
    this.gender,
    this.legalDocumentType,
    this.legalDocumentValue,
    this.phone,
    this.email,
    this.dateOfOperation,
    this.managedBy,
    this.registrationPlace,
    this.charteredCapital,
    this.businessType,
    this.link,
    this.source,
    this.status,
    this.noBusiness,
    this.cccd,
  });

  factory SearchTaxDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTaxDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTaxDataResponseToJson(this);
}
