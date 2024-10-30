// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['accessToken'] as String?,
      json['account'] == null
          ? null
          : AccountResponse.fromJson(json['account'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'account': instance.account?.toJson(),
    };

AccountResponse _$AccountResponseFromJson(Map<String, dynamic> json) =>
    AccountResponse(
      json['fullname'] as String?,
      json['taxCode'] as String?,
      json['address'] as String?,
      json['accountId'] as int?,
      json['companyId'] as int?,
    );

Map<String, dynamic> _$AccountResponseToJson(AccountResponse instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'taxCode': instance.taxCode,
      'address': instance.address,
      'accountId': instance.accountId,
      'companyId': instance.companyId,
    };
