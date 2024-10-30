// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_seller_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformationSellerResponse _$InformationSellerResponseFromJson(
        Map<String, dynamic> json) =>
    InformationSellerResponse(
      account: json['account'] == null
          ? null
          : AccountInformationSellerResponse.fromJson(
              json['account'] as Map<String, dynamic>),
      company: json['company'] == null
          ? null
          : CompanyInformationSellerResponse.fromJson(
              json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InformationSellerResponseToJson(
        InformationSellerResponse instance) =>
    <String, dynamic>{
      'account': instance.account?.toJson(),
      'company': instance.company?.toJson(),
    };

AccountInformationSellerResponse _$AccountInformationSellerResponseFromJson(
        Map<String, dynamic> json) =>
    AccountInformationSellerResponse(
      accountId: json['accountId'] as int?,
      companyId: json['companyId'] as int?,
      accountLevel: json['accountLevel'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      email: json['email'] as String?,
      fullname: json['fullname'] as String?,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      address: json['address'] as String?,
      active: json['active'] as bool?,
      locked: json['locked'] as bool?,
    );

Map<String, dynamic> _$AccountInformationSellerResponseToJson(
        AccountInformationSellerResponse instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'companyId': instance.companyId,
      'accountLevel': instance.accountLevel,
      'isAdmin': instance.isAdmin,
      'email': instance.email,
      'fullname': instance.fullname,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'address': instance.address,
      'active': instance.active,
      'locked': instance.locked,
    };

CompanyInformationSellerResponse _$CompanyInformationSellerResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyInformationSellerResponse(
      companyId: json['companyId'] as int?,
      companyName: json['companyName'] as String?,
      taxCode: json['taxCode'] as String?,
      website: json['website'] as String?,
      fax: json['fax'] as String?,
      bankName: json['bankName'] as String?,
      contactPersonEmail: json['contactPersonEmail'] as String?,
      contactPersonPhone: json['contactPersonPhone'] as String?,
      contactPersonPosition: json['contactPersonPosition'] as String?,
      businessPermitAddress: json['businessPermitAddress'] as String?,
    );

Map<String, dynamic> _$CompanyInformationSellerResponseToJson(
        CompanyInformationSellerResponse instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'taxCode': instance.taxCode,
      'website': instance.website,
      'fax': instance.fax,
      'bankName': instance.bankName,
      'contactPersonEmail': instance.contactPersonEmail,
      'contactPersonPhone': instance.contactPersonPhone,
      'contactPersonPosition': instance.contactPersonPosition,
      'businessPermitAddress': instance.businessPermitAddress,
    };
