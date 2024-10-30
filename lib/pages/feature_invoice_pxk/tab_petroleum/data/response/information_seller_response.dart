import 'package:json_annotation/json_annotation.dart';

part 'information_seller_response.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch
//
//flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class InformationSellerResponse {
  AccountInformationSellerResponse? account;
  CompanyInformationSellerResponse? company;

  InformationSellerResponse({
    this.account,
    this.company,
  });

  factory InformationSellerResponse.fromJson(Map<String, dynamic> json) =>
      _$InformationSellerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InformationSellerResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AccountInformationSellerResponse {
  int? accountId;
  int? companyId;
  String? accountLevel;
  bool? isAdmin;
  String? email;
  String? fullname;
  String? phone;
  String? avatar;
  String? address;
  bool? active;
  bool? locked;

  AccountInformationSellerResponse(
      {this.accountId,
      this.companyId,
      this.accountLevel,
      this.isAdmin,
      this.email,
      this.fullname,
      this.phone,
      this.avatar,
      this.address,
      this.active,
      this.locked});

  factory AccountInformationSellerResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AccountInformationSellerResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AccountInformationSellerResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyInformationSellerResponse {
  int? companyId;
  String? companyName;
  String? taxCode;
  String? website;
  String? fax;
  String? bankName;
  String? contactPersonEmail;
  String? contactPersonPhone;
  String? contactPersonPosition;
  String? businessPermitAddress;

  CompanyInformationSellerResponse(
      {this.companyId,
      this.companyName,
      this.taxCode,
      this.website,
      this.fax,
      this.bankName,
      this.contactPersonEmail,
      this.contactPersonPhone,
      this.contactPersonPosition,
      this.businessPermitAddress});

  factory CompanyInformationSellerResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CompanyInformationSellerResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CompanyInformationSellerResponseToJson(this);
}
